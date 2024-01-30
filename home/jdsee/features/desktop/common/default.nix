{ pkgs, lib, outputs, ... }:
{
  imports = [
    ./discord.nix
    ./firefox.nix
    ./font.nix
    ./gtk.nix
    ./gtkgreet.nix
    ./imv.nix
    ./intellij.nix
    ./obs.nix
    ./pavucontrol.nix
    ./pulsemixer.nix
    ./qt.nix
    ./rbw.nix
    ./typesetting.nix
  ];

  xdg.mimeApps.enable = true;
  home.packages = with pkgs; [
    cinnamon.nemo-with-extensions
    libreoffice

    # communication
    thunderbird
    signal-desktop

    # research
    obsidian
    zotero
  ];

  services.xcape = {
    enable = false;
    mapExpression = {
      Control_L = "Control_L|Escape";
    };
  };
}
