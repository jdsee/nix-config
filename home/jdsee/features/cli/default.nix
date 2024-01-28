{ pkgs, ... }:

{
  imports = [
    ./bat.nix
    ./direnv.nix
    ./git
    ./ranger
    ./tmux
    ./vim.nix
    ./zsh
  ];

  programs = {
    eza = {
      enable = true;
      enableAliases = false; # TODO
    };

    atuin = {
      enable = true;
      flags = [ "--disable-up-arrow" ];
    };
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

      # compression
      p7zip
      unzip
      zip
    ];
  };
}
