{ pkgs, ... }:
{
  imports = [
    ./alacritty.nix
    ./gammastep.nix
    ./mako.nix
    ./swayidle.nix
    ./swaylock.nix
    ./waybar
    ./rofi.nix
    ./zathura.nix
  ];

  home.packages = with pkgs; [
    sway-contrib.grimshot
    grim
    imv
    mimeo
    pulseaudio
    slurp
    waypipe
    wtype
    wf-recorder
    wl-clipboard
    wl-mirror
    ydotool
  ];

  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND = 1;
    QT_QPA_PLATFORM = "wayland";
    LIBSEAT_BACKEND = "logind";
  };
}
