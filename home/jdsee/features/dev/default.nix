{ inputs, lib, pkgs, config, outputs, ... }:
{
  imports = [
    ./c.nix
    ./go.nix
    ./lua.nix
    ./js.nix
    ./python.nix
    ./rust.nix
  ];
}
