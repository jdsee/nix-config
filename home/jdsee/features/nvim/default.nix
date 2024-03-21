{ config, pkgs, lib, inputs, ... }:
let
  system = "x86_64-linux";
in
{
  # TODO: Move Neovim config to separate flake

  programs.neovim = {
    enable = true;
    defaultEditor = true;

    plugins = with pkgs; [
      rustaceanvim
      vimPlugins.nvim-treesitter.withAllGrammars
    ];

    viAlias = true;
    vimdiffAlias = true;

    withNodeJs = true;
    withPython3 = true;

    extraPackages = with pkgs; [ ];
  };

  home.packages = with pkgs; [
    # inputs.nixvim-config.packages.${system}.default
    dockerfile-language-server-nodejs
    elmPackages.elm-language-server
    kotlin-language-server
    lua-language-server
    marksman
    nodePackages_latest.eslint
    nodePackages_latest.pyright
    nodePackages_latest.volar
    nodePackages_latest.typescript-language-server
    nodePackages_latest.bash-language-server
    nil
    texlab
    phpactor
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
