{ inputs, pkgs, ... }:

{
  imports = [
    ./global
    ./features/desktop/hyprland
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowBroken = true;
      permittedInsecurePackages = [
        "electron-25.9.0"
      ];
    };
  };

}
