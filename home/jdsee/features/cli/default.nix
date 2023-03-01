{ pkgs, ... }:

{
  imports = [
    ./bat.nix
    ./git
    ./ranger.nix
    ./tmux.nix
    ./vim.nix
    ./zsh
  ];

  home.packages = with pkgs; [
    # monitoring
    bottom
    htop-vim

    fd # Better find
    httpie # Better curl
    wget # File download
    jq # JSON pretty printer and manipulator
    ncdu # TUI disk usage
    ripgrep # Better grep
    colordiff

    # compression
    p7zip
    unzip
    zip

    # theme
    exa # Better ls
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
  };
}
