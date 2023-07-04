{ config, lib, pkgs, ... }:

{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    cycle = true;
    plugins = with pkgs; [ ];
    theme = "android_notification";
  };

  home.packages = with pkgs; [
    pinentry-rofi
    rofi-rbw
    rofi-power-menu
    bitwarden-menu
  ];
}
