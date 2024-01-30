{ config, lib, pkgs, user, ... }:

{
  programs.tmate = {
    enable = true;
  };

  programs.tmux = {
    enable = true;
    tmuxinator.enable = true;
    package = pkgs.tmux-31c;
    extraConfig = builtins.readFile ./tmux.conf;
    keyMode = "vi";
    shortcut = "f";
    terminal = "screen-256color";
    clock24 = true;
    escapeTime = 1;
    historyLimit = 50000;
    plugins = with pkgs.tmuxPlugins; [
      urlview
      extrakto
    ];
  };

  xdg.configFile."tmuxinator" = {
    source = ./tmuxinator;
    recursive = true;
  };
}
