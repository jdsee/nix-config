{ pkgs, lib, outputs, ... }:
{
  home.packages = with pkgs; [
    texlive.combined.scheme-full
    typst
  ];
}
