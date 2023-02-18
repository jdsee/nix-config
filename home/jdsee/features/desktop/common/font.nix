{ pkgs, ... }:

{
  fontProfiles = {
    enable = true;
    monospace = {
      # TODO: Use Hack
      family = "FiraCode Nerd Font";
      package = pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; };
    };
    regular = {
      family = "Fira Sans";
      package = pkgs.fira;
    };
  };
}
