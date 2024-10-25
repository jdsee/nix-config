{ pkgs, ... }:
{
  imports = [
    ./foot.nix
    ./gammastep.nix
    # ./mako.nix
    ./rofi.nix
    ./waybar
    # ./wezterm
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
    wlr-randr
    nwg-displays
    wtype
    ydotool
    xwaylandvideobridge
  ];

  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND = 1;
    QT_QPA_PLATFORM = "wayland";
    LIBSEAT_BACKEND = "logind";
  };
}
