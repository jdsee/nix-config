{ lib, inputs, outputs, ... }:

{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ./locale.nix
    ./nix.nix
  ] ++ (builtins.attrValues outputs.nixosModules);

  home-manager = {
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs outputs; };
  };

  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays;
    config = {
      allowUnfree = true;
      allowBroken = true;
    };
  };

  networking.networkmanager.enable = true;

  security = {
    polkit.enable = true; # required to setup sway with HomeManager
    pam.services.swaylock = {
      text = "auth include login";
    };
  };

  environment = {
    # persistence = {
    #   "/persist".directories = [ "/var/lib/systemd" "/var/log" "/srv" ];
    # };
    enableAllTerminfo = true;
  };

  programs.fuse.userAllowOther = true;
  hardware.enableRedistributableFirmware = true;
  # networking.domain = "m7.rs";

  # Increase open file limit for sudoers
  # security.pam.loginLimits = [
  #   {
  #     domain = "@wheel";
  #     item = "nofile";
  #     type = "soft";
  #     value = "524288";
  #   }
  #   {
  #     domain = "@wheel";
  #     item = "nofile";
  #     type = "hard";
  #     value = "1048576";
  #   }
  # ];
}
