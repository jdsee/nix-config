{ config, pkgs, lib, inputs, ... }:
{
  # TODO: Move Neovim config to separate flake

  programs.neovim = {
    enable = true;
    defaultEditor = true;

    plugins = with pkgs; [
      rustaceanvim
      # vimPlugins.nvim-treesitter.withAllGrammars
    ];

    viAlias = true;
    vimdiffAlias = true;

    withNodeJs = true;
    withPython3 = true;
  };

  home.packages = with pkgs; [
    # inputs.nixvim-config.packages.${system}.default
    dockerfile-language-server-nodejs
    elmPackages.elm-language-server
    kotlin-language-server
    lua-language-server
    marksman
    nil
    nixpkgs-fmt
    nodePackages_latest.bash-language-server
    nodePackages_latest.eslint
    nodePackages_latest.typescript-language-server
    # nodePackages_latest.volar
    ocamlPackages.ocaml-lsp
    phpactor
    tailwindcss-language-server
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
