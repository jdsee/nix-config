{ config, lib, pkgs, ... }:

{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    cycle = true;
    plugins = [];
    theme = "android_notification";
  };
}
