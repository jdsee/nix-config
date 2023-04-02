{ config, lib, pkgs, user, ... }:

{
  services.flameshot = {
    enable = true;
    package = pkgs.flameshot-wayland;
  };
}
