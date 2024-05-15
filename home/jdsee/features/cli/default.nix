{ pkgs, ... }:

{
  imports = [
    ./atuin.nix
    ./git
    ./tmux
    ./vim.nix
    ./zsh
  ];

  programs = {
    nushell.enable = true;

    eza.enable = true;

    bat = {
      enable = true;
      config.theme = "base16";
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    lazygit.enable = false;

  };

  home = {
    sessionVariables = {
      EDITOR = "nvim";
    };

    packages = with pkgs; [
      file
      lsof
      networkmanagerapplet

      fd # Better find
      httpie # Better curl
      hyperfine # Micro benchmark
      wget # File download
      jq # JSON pretty printer and manipulator
      ncdu # TUI disk usage
      ripgrep # Better grep
      colordiff # Colored diff
      restic # Backup tool
      bottom # Monitoring like htop
      lazydocker # Docker TUI
      openconnect # VPN
      pdftk # PDF utils
      steam-run # Emulate FHS file system
      tomato-c # Focus timer
      tldr # Abbreviated man pages
      dust # More intuitive alternative to du
      rlwrap # Add history and easier navigation in line-reading programs
      nh # Reimplementation of common nix-commands

      # compression
      p7zip
      unzip
      zip
    ];
  };

  xdg.configFile = {
    "ideavim/ideavimrc" = {
      source = ./ideavimrc;
    };
  };


}
