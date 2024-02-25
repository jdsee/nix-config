{ pkgs, ... }:
{
  fontProfiles = {
    enable = true;
    monospace = {
      family = "Hack Nerd Font";
      package = pkgs.nerdfonts.override { fonts = [ "Hack" ]; };
    };
    regular = {
      family = "FiraCode Nerd Font";
      package = pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; };
    };
  };
}
