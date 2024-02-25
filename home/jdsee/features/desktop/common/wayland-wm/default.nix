{ pkgs, ... }:
{
  imports = [
    # ./alacritty.nix
    ./eww
    ./foot.nix
    ./fuzzel.nix
    ./gammastep.nix
    ./mako.nix
    ./rofi.nix
    ./swayidle.nix
    ./swaylock.nix
    ./gtklock.nix
    ./waybar
    ./zathura.nix
  ];

  home.packages = with pkgs; [
    grim
    imv
    mimeo
    pulseaudio
    slurp
    satty # screenshot annotator (swappy would be an alternative)
    theme-sh
    waypipe
    wf-recorder
    wl-clipboard
    wl-mirror
    wtype
    ydotool
  ];

  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND = 1;
    QT_QPA_PLATFORM = "wayland";
    LIBSEAT_BACKEND = "logind";
  };
}
