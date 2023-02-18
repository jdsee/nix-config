{ config, lib, pkgs, ... }:
let
  wofi = pkgs.wofi.overrideAttrs (oa: {
    patches = (oa.patches or [ ]) ++ [
      ./wofi-run-shell.patch # Fix for https://todo.sr.ht/~scoopta/wofi/174
    ];
  });
in
{
  home.packages = with pkgs; [ wofi rofi-rbw ];

  # TODO: Bitwarden integration

  xdg.configFile."wofi/config".text = ''
    allow_images=true
    insensitive=true

    run-always_parse_args=true
    run-cache_file=/dev/null
    run-exec_search=true
  '';
}
