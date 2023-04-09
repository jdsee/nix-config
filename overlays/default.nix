{ inputs, outputs }:
{
  # custom packages from the 'pkgs' directory
  additions = final: prev: import ../pkgs { pkgs = final; };

  neovim-nightly = inputs.neovim-nightly-overlay.overlay;

  modifications = final: prev: {
    # Activate experimential features in waybar
    waybar-experimental = prev.waybar.overrideAttrs (old: {
      mesonFlags = old.mesonFlags ++ [ "-Dexperimental=true" ];

      # Support for persistent workspaces - TODO: remove when PR merged
      src = final.fetchFromGitHub {
          owner = "MonstrousOgre";
          repo = "Waybar_hyprland_persistent";
          rev = "master";
          sha256 = "sha256-rD2K7hy3o7fDwC9usyhNJh4iasgGev8PpAbCUaiAtRU=";
        };
    });

    ranger-sixel = prev.ranger.overrideAttrs (old: {
      patches = (old.patches or [ ]) ++ [
        (prev.fetchpatch {
          url = "https://github.com/3ap/ranger/commit/ef9ec1f0e0786e2935c233e4321684514c2c6553.patch";
          sha256 = "sha256-MJbIBuFeOvYnF6KntWJ2ODQ4KAcbnFEQ1axt1iQGkWY=";
        })
      ];
    });

    flameshot-wayland = prev.flameshot.overrideAttrs (old: {
      src = final.fetchFromGitHub {
        owner = "flameshot-org";
        repo = "flameshot";
        rev = "3ededae";
        hash = "sha256-4SMg63MndCctpfoOX3OQ1vPoLP/90l/KGLifyUzYD5g=";
      };
      cmakeFlags = [ "-DUSE_WAYLAND_GRIM=true" ];
    });

  };
}
