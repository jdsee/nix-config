{ config, pkgs, ... }:

{
  # TODO: This is broken on hyprland atm

  home.packages = with pkgs; [
    gtklock
    gtklock-powerbar-module
  ];

  xdg.configFile = {
    "gtklock/config.ini" = {
      text = ''
        [main]
        style=/home/jdsee/.config/gtklock/style.css
        module=${pkgs.gtklock-powerbar-module}/lib/gtklock/powerbar-module.so
        lock-command=${pkgs.rbw}/bin/rbw lock
      '';
    };
    "gtklock/style.css" = {
      text = ''
        window {
           background-image: url("/home/jdsee/.config/wallpapers/star-wars-broken-ship.jpg");
           background-size: cover;
           background-repeat: no-repeat;
           background-position: center;
           background-color: black;
        }
      '';
    };
  };
}
