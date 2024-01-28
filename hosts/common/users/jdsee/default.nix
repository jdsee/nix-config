{ pkgs, config, lib, outputs, ... }:

let
  user = "jdsee";
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in
{
  users.mutableUsers = true;
  users.users.${user} = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [
      "audio"
      "camera"
      "input"
      "jackaudio"
      "networkManager"
      "uinput"
      "video"
      "wheel"
    ] ++ ifTheyExist [
      "deluge"
      "docker"
      "git"
      "i2c"
      "libvirtd"
      "network"
    ];

    # passwordFile = config.sops.secrets.${user}-password.path;
    packages = [ pkgs.home-manager ];
  };

  home-manager.users.${user} = import home/${config.networking.hostName}.nix;

  services.geoclue2.enable = true;
  security.pam.services = { swaylock = { }; };
}
