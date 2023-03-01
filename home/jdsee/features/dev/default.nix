{ inputs, lib, pkgs, config, outputs, ... }:
{
  imports = [
    ./c.nix
    ./go.nix
    ./lua.nix
    ./python.nix
    ./rust.nix
  ];
}
