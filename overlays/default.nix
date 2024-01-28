{ inputs, outputs }:
{
  # custom packages from the 'pkgs' directory
  additions = final: prev: import ../pkgs { pkgs = final; };

  neovim-nightly = inputs.neovim-nightly-overlay.overlay;
}
