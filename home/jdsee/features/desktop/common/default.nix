{ pkgs, lib, outputs, ... }:
{
  imports = [
    ./firefox.nix
    ./font.nix
    ./gtk.nix
    ./pavucontrol.nix
    ./rbw.nix
    ./qt.nix
  ];

  xdg.mimeApps.enable = true;
  home.packages = with pkgs; [
    # communication
    thunderbird
    signal-desktop

    # editing
    texlive.combined.scheme-full
  ];
}
