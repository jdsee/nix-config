{ inputs, lib, pkgs, config, outputs, ... }:
{
  imports = [
    ./c.nix
    ./go.nix
    ./gleam.nix
    ./lua.nix
    ./java.nix
    ./js.nix
    ./python.nix
    ./rust.nix
  ];

  home.packages = with pkgs; [
    exercism
  ];
}
