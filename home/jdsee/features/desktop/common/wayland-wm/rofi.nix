{ config, lib, pkgs, ... }:

{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    plugins = with pkgs; [
      rofi-rbw
      rofi-power-menu
    ];
    theme = "${config.xdg.configHome}/rofi/rofi-themes-collection/themes/squared-everforest.rasi";
    font = "${config.fontProfiles.regular.family} 12";
    terminal = "${pkgs.foot}";
    cycle = true;
  };

  home.packages = with pkgs; [
    pinentry-rofi
    rofi-rbw
    rofi-power-menu
    bitwarden-menu
  ];

  xdg.configFile = {
    "rofi/rofi-themes-collection" = {
      source = pkgs.fetchFromGitHub {
        owner = "newmanls";
        repo = "rofi-themes-collection";
        rev = "5bc150394bf785b2751711e3050ca425c662938e";
        hash = "sha256-k737CFrtbGfpqBxBOhrAD/QRC0aDryFs0jB4fycUooI=";
      };
      recursive = true;
    };
  };
}
