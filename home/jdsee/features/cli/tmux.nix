{ config, lib, pkgs, user, ... }:

{
  programs.tmux = {
    enable = true;
    tmuxinator.enable = true;
    keyMode = "vi";
    shortcut = "f";
    terminal = "screen-256color";
    clock24 = true;
    escapeTime = 1;
    historyLimit = 50000;
    plugins = with pkgs; [
      tmuxPlugins.urlview
    ];
    extraConfig = ''
      # Status bar colors
      set-option -g status-style bg=default # transparent bg
      set -g status-fg white
      set-window-option -g window-status-current-style fg=black,bg=white

      set-option -g base-index 1
      set-window-option -g pane-base-index 1

      setw -g mouse on

      # Reload tmux.conf
      unbind r
      bind r source-file ~/.tmux.conf

      # Jump to last pane and maximize it
      bind O "last-pane ; resize-pane -Z"

      # Toggle status bar
      bind-key q set-option status

      # Center windows in status line
      set -g status-justify centre

      # VI style movements
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R

      # VI style resize
      bind -r C-h resizep -L
      bind -r C-j resizep -D
      bind -r C-k resizep -U
      bind -r C-l resizep -R

      # Open from current directory
      bind C-c new-window -c '#{pane_current_path}'
      bind '"' split-window -c '#{pane_current_path}'
      bind % split-window -h -c '#{pane_current_path}'

      # Search cheatsheet (thanks to the primeagen)
      # TODO: bind -r i run-shell "tmux popup -w 75% -h 75% ~/cht.sh.tmux.sh"
    '';
  };
}
