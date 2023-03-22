{ pkgs, lib, outputs, ... }:
{
  imports = [
    ./firefox.nix
    ./font.nix
    ./gtk.nix
    ./intellij.nix
    ./pavucontrol.nix
    ./pulsemixer.nix
    ./qt.nix
    ./rbw.nix
  ];

  xdg.mimeApps.enable = true;
  home.packages = with pkgs; [
    # communication
    thunderbird
    signal-desktop

    # editing
    texlive.combined.scheme-full

    # other
    sonic-pi
  ];
}
