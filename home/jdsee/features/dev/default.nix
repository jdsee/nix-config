{  pkgs, ... }:
{
  imports = [
    ./c.nix
    ./go.nix
    ./gleam.nix
    ./lua.nix
    # ./java.nix
    ./js.nix
    ./ocaml.nix
    ./python.nix
    ./rust.nix
  ];

  home.packages = with pkgs; [
    exercism
  ];
}
