{ inputs, outputs }:
{
  # custom packages from the 'pkgs' directory
  additions = final: prev: import ../pkgs { pkgs = final; };

  neovim-nightly = inputs.neovim-nightly-overlay.overlay;

  modifications = final: prev: {

    # TODO: update revision
    flameshot-wayland = prev.flameshot.overrideAttrs (old: {
      src = final.fetchFromGitHub {
        owner = "flameshot-org";
        repo = "flameshot";
        rev = "3ededae";
        hash = "sha256-4SMg63MndCctpfoOX3OQ1vPoLP/90l/KGLifyUzYD5g=";
      };
      cmakeFlags = [ "-DUSE_WAYLAND_GRIM=true" ];
    });

    tmux-31c = prev.tmux.overrideAttrs (old: rec {
      version = "3.1c";
      patches = [];
      src = final.fetchFromGitHub {
        owner = "tmux";
        repo = "tmux";
        rev = version;
        sha256 = "sha256-jkGcaghCP4oqw280pLt9XCJEZDZvb9o1sK0grdy/D7s=";
      };
    });

  };
}
