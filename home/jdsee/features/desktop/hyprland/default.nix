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
    # hyprlock <- doesn't work on non-nixos-systems atm
    hypridle
    hyprpicker
    kanshi # dynamic monitor configuration
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
    "hypr/hyprlock.conf" = {
      text = builtins.readFile ./hyprlock.conf;
    };
    "hypr/hypridle.conf" = {
      text = builtins.readFile ./hypridle.conf;
    };
    "hypr/clean_start_xdg_desktop_portal_hyprland.sh".source = ./clean_start_xdg_desktop_portal_hyprland.sh;
    "xdg-desktop-portals/hyprland-portals.conf".text = ''
      [preferred]
      default=hyprland;gtk
      org.freedesktop.impl.portal.FileChooser=gnome
    '';
    "hypr/hyprpaper.conf" = {
      text = ''
        ipc = off
        preload = ~/.config/wallpapers/star-wars-broken-ship.jpg
        preload = ~/.config/wallpapers/Road-Trip_2560x1440.png
        wallpaper = eDP-1,~/.config/wallpapers/Road-Trip_2560x1440.png
        wallpaper = DP-1,~/.config/wallpapers/Road-Trip_2560x1440.png
        wallpaper = DP-2,~/.config/wallpapers/Road-Trip_2560x1440.png
        wallpaper = DP-3,~/.config/wallpapers/Road-Trip_2560x1440.png
        wallpaper = DP-4,~/.config/wallpapers/Road-Trip_2560x1440.png
        wallpaper = DP-5,~/.config/wallpapers/Road-Trip_2560x1440.png
        wallpaper = HDMI-A-1,~/.config/wallpapers/Road-Trip_2560x1440.png
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
