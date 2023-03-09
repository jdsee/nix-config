{ inputs, pkgs, ... }:

{
  imports = [
    ./global
    ./wsl
  ];

  home = {
    username = "seelij";
    homeDirectory = /home/seelij;
  };
}
