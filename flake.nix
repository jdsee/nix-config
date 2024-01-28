{
  description = "My personal Nix configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-master.url = "github:nixos/nixpkgs/master";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    # xremap-flake.url = "github:xremap/nix-flake";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs @ { self
    , nixpkgs
    , home-manager
    , xremap-flake
    , ...
    }:
    let
      inherit (self) outputs;
      forEachSystem = nixpkgs.lib.genAttrs [ "x86_64-linux" "aarch64-linux" ];
      forEachPkgs = f: forEachSystem (sys: f nixpkgs.legacyPackages.${sys});
      sys = "x86_64-linux";
    in
    {
      nixosModules = import ./modules/nixos;
      homeManagerModules = import ./modules/home-manager;

      overlays = import ./overlays { inherit inputs outputs; };

      packages = forEachPkgs (pkgs: import ./pkgs { inherit pkgs; });
      devShells = forEachPkgs (pkgs: import ./shell.nix { inherit pkgs; });
      formatter = forEachPkgs (pkgs: pkgs.nixpkgs-fmt);

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
          pkgs = import nixpkgs { system = "x86_64-linux"; };
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [ ./home/jdsee/cogitare.nix ];
        };
        "jdsee@exodus" = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs { system = "x86_64-linux"; };
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
