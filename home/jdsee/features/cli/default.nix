{ pkgs, ... }:

{
  imports = [
    ./zsh
    ./bat.nix
    ./tmux.nix
    ./git.nix
    ./ranger.nix
    ./vim.nix
  ];

  home.packages = with pkgs; [
    # monitoring
    bottom
    htop-vim

    fd # Better find
    httpie # Better curl
    jq # JSON pretty printer and manipulator
    ncdu # TUI disk usage
    ripgrep # Better grep

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
