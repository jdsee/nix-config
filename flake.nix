{
  description = "My personal Nix configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-master.url = "github:nixos/nixpkgs/master";
    flake-utils.url = "github:numtide/flake-utils";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    xremap-flake.url = "github:xremap/nix-flake";
    rustaceanvim.url = "github:mrcjkb/rustaceanvim";

    nix-ld-rs = {
      url = "github:nix-community/nix-ld-rs";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ { self, nixpkgs, home-manager, flake-utils, xremap-flake, nixvim, ... }:
    let
      inherit (self) outputs;
      forEachSystem = flake-utils.lib.eachDefaultSystem;
    in
    {
      packages = forEachSystem (system: import ./pkgs nixpkgs.legacyPackages.${system});
      formatter = forEachSystem (system: nixpkgs.legacyPackages.${system}.alejandra);
      overlays = import ./overlays { inherit inputs; };
      nixosModules = import ./modules/nixos;
      homeManagerModules = import ./modules/home-manager;

      defaultPackage.x86_64-linux = home-manager.defaultPackage.x86_64-linux;

      # nixos-rebuild switch --flake .#your-hostname
      nixosConfigurations = {
        cogitare = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [
            ./hosts/cogitare
            xremap-flake.nixosModules.default
          ];
        };
        exodus = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [
            ./hosts/exodus
            xremap-flake.nixosModules.default
          ];
        };
      };

      # home-manager switch --flake .#your-username@your-hostname
      homeConfigurations = {
        "jdsee@cogitare" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [ ./home/jdsee/cogitare.nix ];
        };
        "jdsee@exodus" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [ ./home/jdsee/cogitare.nix ];
        };
        "seelij@nuntius" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [ ./home/jdsee/nuntius.nix ];
        };
      };
    };
}
