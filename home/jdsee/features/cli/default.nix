{ pkgs, ... }:

{
  imports = [
    ./bat.nix
    ./direnv.nix
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
    colordiff # Colored diff

    # compression
    p7zip
    unzip
    zip

    # theme
    exa # Better ls

    # tui
    lazydocker
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
  };
}
