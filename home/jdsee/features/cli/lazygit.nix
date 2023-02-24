{ config, lib, pkgs, user, ... }:

{
  programs.lazygit = {
    enable = true;
  };
}
