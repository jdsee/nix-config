{ config, lib, pkgs, user, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;

    defaultKeymap = "emacs";

    plugins = [
      {
        name = "zsh-nix-shell";
        file = "nix-shell.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "chisui";
          repo = "zsh-nix-shell";
          rev = "v0.5.0";
          sha256 = "0za4aiwwrlawnia4f29msk822rj9bgcygw6a8a6iikiwzjjz0g91";
        };
      }
    ];

    zplug = {
      enable = true;
      plugins = [
        { name = "mafredri/zsh-async"; }
        { name = "sindresorhus/pure"; }
      ];
    };

    history = {
      size = 100000;
      save = 1000000;
      share = true;
      expireDuplicatesFirst = true;
      ignoreSpace = true;
    };

    sessionVariables = {
      PATH = "$PATH:$HOME/bin";
      GPG_TTY = "$(tty)";
      MANPAGER = "sh -c 'col -bx | bat -l man -p'";
      PURE_NODE_ENABLED = 0;
      PURE_CMD_MAX_EXEC_TIME = 1;
    };

    profileExtra = ''
      if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then
        . $HOME/.nix-profile/etc/profile.d/nix.sh
      fi
    '';

    initExtra = ''
      eval "$(ssh-agent)" >/dev/null

      # Script to open man-page in tmux popup
      source ~/.config/zsh/popman.sh
      zle -N popman
      bindkey  popman
      bindkey '^O' autosuggest-accept

      #THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
      export SDKMAN_DIR="$HOME/.sdkman"
      [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
    '';

    shellAliases = {
      vind = "nvim -c 'Telescope zoxide list'";

      ls = "exa";
      ll = "ls -alh";
      la = "ls -a";
      ld = "ls -ad";
      tree = "la --tree";
      trees = "tree --depth 4";

      ".." = "cd ../";
      "..." = "cd ../../";
      "...." = "cd ../../../";
      "....." = "cd ../../../../";
      "......" = "cd ../../../../../";

      lg = "lazygit";
      rmgi = "git rm -r --cached . && git add . && git status";
      conflicts = "grep -lr '<<<<<<<' .";

      _ = "sudo";
      cat = "bat -p";
      grep = "grep --color";
      hg = "history 0 | grep";
      mycolors = "msgcat --color=test";
      view = "zathura";
      diff = "colordiff";
      clip = "xclip -sel clip";

      tx = "tmuxinator";

      update = "sudo nixos-rebuild switch --flake .#jdsee";
    };
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    tmux.enableShellIntegration = false;
  };

  programs.bat = {
    enable = true;
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    options = [
      "--cmd j"
    ];
  };

  xdg.configFile.zsh = {
    source = ./config/zsh;
    recursive = true;
  };
}
