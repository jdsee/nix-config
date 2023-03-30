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
    "ranger/plugins/zoxide" = {
      source = pkgs.fetchFromGitHub {
        owner = "jchook";
        repo = "ranger-zoxide";
        rev = "363df97af34c96ea873c5b13b035413f56b12ead";
        sha256 = "sha256-HFCGuAektrSHF7GJsoKv1TJ/T/dwkYK1eUcw8nEjJII=";
      };
    };
  };
}
