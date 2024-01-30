{ inputs, ... }:
{
  # custom packages from the 'pkgs' directory
  additions = final: prev: import ../pkgs { pkgs = final; };

  # When applied, the unstable nixpkgs set (declared in the flake inputs) will
  # be accessible through 'pkgs.unstable'
  unstable-packages = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = final.system;
      config.allowUnfree = true;
    };
  };

  neovim-nightly = inputs.neovim-nightly-overlay.overlay;

  modifications = final: prev: {

    tmux-31c = prev.tmux.overrideAttrs (old: rec {
      version = "3.1c";
      patches = [ ];
      src = final.fetchFromGitHub {
        owner = "tmux";
        repo = "tmux";
        rev = version;
        sha256 = "sha256-jkGcaghCP4oqw280pLt9XCJEZDZvb9o1sK0grdy/D7s=";
      };
    });

    flameshot-wayland = prev.flameshot.overrideAttrs (old: {
      cmakeFlags = [ "-DUSE_WAYLAND_GRIM=true" ];
    });

  };
}
