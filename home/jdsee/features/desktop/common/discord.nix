{ pkgs, lib, inputs, ... }:
{
  home.packages = with pkgs; [
    discord
  ];
}
