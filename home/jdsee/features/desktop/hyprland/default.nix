{ inputs, lib, config, pkgs, ... }: {
  imports = [
    ../common
    ../common/wayland-wm
    inputs.hyprland.homeManagerModules.default
  ];

  programs = {
    zsh.loginExtra = ''
      if [ "$(tty)" = "/dev/tty1" ]; then
        exec Hyprland &> /dev/null
      fi
    '';
    zsh.profileExtra = ''
      if [ "$(tty)" = "/dev/tty1" ]; then
        exec Hyprland &> /dev/null
      fi
    '';
  };

  home.packages = with pkgs; [
    inputs.hyprwm-contrib.packages.${system}.grimblast
    hyprpaper
    swaybg
    swayidle
  ];

  programs.waybar.package = pkgs.waybar.overrideAttrs (oa: {
    mesonFlags = (oa.mesonFlags or  [ ]) ++ [ "-Dexperimental=true" ];
  });

  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.default;
    extraConfig = import ./config.nix { };
    xwayland.enable = true;
  };

  xdg.configFile = {
    wallpapers = {
      source = ../../../resources/Wallpapers;
      recursive = true;
    };
  };

  xdg.configFile = {
    "hypr/hyprpaper.conf" = {
      text = ''
        ipc = off
        preload = ~/.config/wallpapers/star-wars-broken-ship.jpg
        wallpaper = eDP-1,~/.config/wallpapers/star-wars-broken-ship.jpg
        wallpaper = DP-2,~/.config/wallpapers/star-wars-broken-ship.jpg
      '';
    };
  };
}
