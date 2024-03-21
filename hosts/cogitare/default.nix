{ inputs, outputs, lib, config, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix

    ../common/global
    ../common/users/jdsee

    # ../common/opt/virtualbox.nix
    ../common/opt/docker.nix
    ../common/opt/greetd.nix
    ../common/opt/pipewire.nix
    ../common/opt/polkit.nix
    ../common/opt/systemd_boot.nix
    ../common/opt/udisks.nix
    ../common/opt/xremap.nix
  ];

  programs.zsh.enable = true;

  networking = {
    hostName = "cogitare";
  };

  services.dbus.packages = [ pkgs.gcr ];

  powerManagement.powertop.enable = true;

  programs = {
    light.enable = true;
    dconf.enable = true;
    adb.enable = false;
    kdeconnect.enable = false;
  };

  services.logind = {
    lidSwitch = "lock";
    lidSwitchExternalPower = "lock";
  };

  systemd.services = {
    NetworkManager-wait-online.enable = false;
    systemd-udevd.restartIfChanged = false;
  };

  services = {
    blueman.enable = true;
    openssh.enable = true;
    pcscd.enable = true;
  };

  hardware = {
    bluetooth.enable = true;
    opengl = {
      enable = true;
      extraPackages = with pkgs; [ amdvlk ];
      driSupport = true;
      driSupport32Bit = true;
    };
  };

  system.stateVersion = "22.05";
}

