{ pkgs, lib, inputs, ... }:
{

  home.packages = with pkgs; [
    jetbrains.idea-ultimate
  ];
}
