{ pkgs, ... }:
{
  home.packages = with pkgs; [
    cage
    greetd.gtkgreet
  ];
}
