{ pkgs, ... }:

{
  imports = [
    ./global
    ./features/desktop/common/wayland-wm/foot.nix
    ./features/desktop/common/wayland-wm/rofi.nix
    # ./features/desktop/hyprland
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowBroken = true;
      permittedInsecurePackages = [ ];
    };
  };

  programs.firefox = {
    enable = true;
  };

  home.packages = with pkgs; [
    signal-desktop
    element-desktop-wayland
    hyprpaper
    hypridle
    hyprpicker
    wofi
    bitwarden
  ];

}
