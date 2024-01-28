{ inputs, lib, config, pkgs, ... }: {
  imports = [
    ../common
    ../common/wayland-wm
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
    hyprpaper
    swaybg
    swayidle
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = import ./config.nix pkgs;
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
        wallpaper = DP-1,~/.config/wallpapers/star-wars-broken-ship.jpg
        wallpaper = DP-2,~/.config/wallpapers/star-wars-broken-ship.jpg
        wallpaper = DP-3,~/.config/wallpapers/star-wars-broken-ship.jpg
        wallpaper = DP-4,~/.config/wallpapers/star-wars-broken-ship.jpg
        wallpaper = DP-5,~/.config/wallpapers/star-wars-broken-ship.jpg
        wallpaper = HDMI-A-1,~/.config/wallpapers/star-wars-broken-ship.jpg
      '';
    };
    "hypr/disable_internal_monitor.sh" = {
      executable = true;
      text = ''
        #! /usr/bin/env bash
        if (( "$(hyprctl monitors -j | jq length)" > 1 )) ; then
          hyprctl keyword monitor "eDP-1, disable"
        fi
      '';
    };
  };
}
