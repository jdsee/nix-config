{ pkgs, ... }:

{
  imports = [
    ./atuin.nix
    ./babashka.nix
    ./bat.nix
    ./direnv.nix
    ./exa.nix
    ./git
    ./ranger
    ./tmux.nix
    ./vim.nix
    ./zsh
  ];

  home.packages = with pkgs; [
    # monitoring
    bottom
    htop-vim

    # util
    file
    lsof
    networkmanagerapplet

    fd # Better find
    httpie # Better curl
    wget # File download
    jq # JSON pretty printer and manipulator
    ncdu # TUI disk usage
    ripgrep # Better grep
    colordiff # Colored diff

    # compression
    p7zip
    unzip
    zip

    # tui
    lazydocker
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
  };
}
