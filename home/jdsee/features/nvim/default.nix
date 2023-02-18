{ config, pkgs, lib, ... }:
{
  home.sessionVariables.EDITOR = "nvim";

  programs.neovim = {
    enable = true;
    # package = pkgs.neovim-nightly;

    viAlias = true;
    vimdiffAlias = true;

    withNodeJs = true;
    withPython3 = true;

    extraPackages = with pkgs; [
      # TODO: Manage LSP servers with Zero.nvim
      rnix-lsp
      sumneko-lua-language-server
      java-language-server
    ];
  };

  xdg.configFile = {
    nvim = {
      source = ./config/nvim;
      recursive = true;
    };
    # TODO: pre-install treesitter grammars
  };
}
