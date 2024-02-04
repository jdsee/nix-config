{ config, pkgs, lib, ... }:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;

    package = pkgs.neovim-nightly;

    plugins = [
      pkgs.rustaceanvim
    ];

    viAlias = true;
    vimdiffAlias = true;

    withNodeJs = true;
    withPython3 = true;

    extraPackages = with pkgs; [ ];
  };

  home.packages = with pkgs; [
    dockerfile-language-server-nodejs
    elmPackages.elm-language-server
    kotlin-language-server
    lua-language-server
    marksman
    nodePackages_latest.eslint
    nodePackages_latest.pyright
    nodePackages_latest.typescript-language-server
    nodePackages_latest.bash-language-server
    rnix-lsp
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
