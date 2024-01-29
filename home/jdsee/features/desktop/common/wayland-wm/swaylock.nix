{ config, pkgs, ... }:

{
  # home.packages = [ pkgs.swaylock-effects ];
  programs.swaylock = {
    package = pkgs.swaylock-effects;
    settings = {
      image = "$HOME/.config/wallpapers/star-wars-broken-ship.jpg";
      fade-in = 0.1;
      clock = true;
      font = config.fontProfiles.regular.family;
      font-size = 15;
      line-uses-inside = true;
      disable-caps-lock-text = true;
      indicator = true;
      indicator-caps-lock = true;
      indicator-radius = 40;
      indicator-idle-visible = true;
      indicator-y-position = 1000;
    };
  };
}
