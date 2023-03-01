{ inputs, outputs }:
{
  # custom packages from the 'pkgs' directory
  additions = final: prev: import ../pkgs { pkgs = final; };

  neovim-nightly = inputs.neovim-nightly-overlay.overlay;

  modifications = final: prev: {
    nixpkgs.overlays = [
      # Activate experimential features in waybar
      (final: prev: {
        waybar = prev.waybar.overrideAttrs (oldAttrs: {
          mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
        });
      })
    ];
  };
}
