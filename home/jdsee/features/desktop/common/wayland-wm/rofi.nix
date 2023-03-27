{ config, lib, pkgs, ... }:

{
  programs.rofi = {
    enable = false; # TODO: Use home-manager in conjunction with adi1090x/rofi
    package = pkgs.rofi-wayland;
    cycle = true;
    plugins = [];
    theme = "android_notification";
  };

  home.packages = with pkgs; [
    rofi
    rofi-rbw
    rofi-bluetooth
  ];
}
