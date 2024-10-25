{ pkgs, ... }:

{
  imports = [
    ./global
    ./features/desktop/common/wayland-wm/foot.nix
    ./features/desktop/common/wayland-wm/rofi.nix
    ./features/desktop/common/firefox.nix
    ./features/desktop/common/kanata
    # ./features/desktop/hyprland
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowBroken = true;
      permittedInsecurePackages = [ ];
    };
  };

  home.packages = with pkgs; [
    # element-desktop-wayland
    awscli2
    # bitwarden
    bun
    entr
    flameshot
    gopass
    signal-desktop
    thunderbird
    # zed-editor
  ];

  xdg.configFile."ideavim/ideavimrc".source = ./features/cli/ideavimrc;

}
