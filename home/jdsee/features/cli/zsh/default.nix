{ config, lib, pkgs, user, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = false; # leads to bugs when enabled - zplug already calls compinit
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    defaultKeymap = "emacs";

    plugins = [
      {
        name = "zsh-nix-shell";
        file = "nix-shell.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "chisui";
          repo = "zsh-nix-shell";
          rev = "v0.8.0";
          sha256 = "1lzrn0n4fxfcgg65v0qhnj7wnybybqzs4adz7xsrkgmcsr0ii8b7";
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
      PATH = "$PATH:$HOME/bin:$HOME/.config/rofi/scripts";
      GPG_TTY = "$(tty)";
      MANPAGER = "sh -c 'col -bx | bat -l man -p'";
      PURE_NODE_ENABLED = 0;
      PURE_CMD_MAX_EXEC_TIME = 1;
      LAUNCHER = "launcher_t4";
    };

    profileExtra = ''
      if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then
        . $HOME/.nix-profile/etc/profile.d/nix.sh
      fi

      export LAUNCHER=launcher_t4
    '';

    initExtra = ''
      eval "$(ssh-agent)" >/dev/null

      # helper to make modifiable copy of immutable link to nix store
      function tinker() {
        FILE=$1
        mv $1 $1.bak
        cp $1.bak $1
        chmod +w $1
        vi $1
      }

      # generate gitignore file
      # i.e.: `ignore ocaml linux macos`
      function ignore() {
        local IFS=,
        curl "https://www.toptal.com/developers/gitignore/api/$*" >> .gitignore
      }

      export PATH="$PATH:$HOME/bin:$HOME/.config/rofi/scripts:$HOME/.cargo/bin";

      # Script to open man-page in tmux popup
      source ~/.config/zsh/popman.sh
      zle -N popman
      bindkey  popman
      bindkey '^O' autosuggest-accept
    '';

    shellAliases = {
      vind = "nvim -c 'Telescope zoxide list'";
      vile = "nvim -c 'Telescope find_files'";
      oil= "nvim -c Oil";

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

      mux = "tmuxinator";

      htwconnect = "rbw get account.htw-berlin.de | sudo openconnect --protocol anyconnect --passwd-on-stdin --user=s0566845@htw-berlin.de --authgroup=HTW-SSL-VPN-Full https://vpncl.htw-berlin.de";
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
