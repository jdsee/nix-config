{ pkgs, ... }: {
  home.packages = with pkgs; [
    ranger-sixel
    imagemagick # expected by sixel patch
  ];

  xdg.configFile = {
    ranger = {
      source = ./config;
      recursive = true;
    };
  };
}
