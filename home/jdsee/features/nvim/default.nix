{ config, pkgs, lib, ... }:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;

    package = pkgs.neovim-nightly;

    viAlias = true;
    vimdiffAlias = true;

    withNodeJs = true;
    withPython3 = true;

    extraPackages = with pkgs; [ ];
  };

  home.packages = with pkgs; [
    dockerfile-language-server-nodejs
      lua-language-server
      marksman
      nodePackages.eslint
      nodePackages.pyright
      nodePackages.typescript-language-server
      rnix-lsp
      rust-analyzer
      texlab
      vscode-langservers-extracted # html/css/json/eslint
      yaml-language-server
  ];

  xdg.configFile = {
    nvim = {
      source = ./config/nvim;
      recursive = true;
    };
  };
}
