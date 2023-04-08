{ inputs, outputs, lib, config, pkgs, ... }:
let
  user = "jdsee";
in {
  imports = [
    ./hardware-configuration.nix

    ../common/global
    ../common/users/jdsee

    ../common/opt/virtualbox.nix
    ../common/opt/docker.nix
    ../common/opt/pipewire.nix
    ../common/opt/polkit.nix
    ../common/opt/systemd_boot.nix
    ../common/opt/udisks.nix
  ];

  services.greetd.settings.default_session.user = user;

  programs.zsh.enable = true;

  networking = {
    hostName = "cogitare";
  };

  services.dbus.packages = [ pkgs.gcr ];

  powerManagement.powertop.enable = true;

  programs = {
    light.enable = true;
    dconf.enable = true;
    adb.enable = false;
    kdeconnect.enable = false;
  };

  services.logind = {
    lidSwitch = "lock";
    lidSwitchExternalPower = "lock";
  };

  systemd.services = {
    keyd = {
      enable = false;
      description = "key remapping daemon";
      requires = [ "local-fs.target" ];
      after = [ "local-fs.target" ];
      wantedBy = [ "sysinit.target" ];
      unitConfig = {
        Type = "simple";
      };
      serviceConfig = {
        ExecStart = "/usr/bin/keyd";
      };
    };
  };

  services = {
    blueman.enable = true;
    openssh.enable = true;
    pcscd.enable = true;
    # kubernetes = {
    #   roles = [ "master" "node" ];
    #   masterAddress = "master.jdsee.de";
    # };
  };

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
    ];
  };

  hardware = {
    bluetooth.enable = true;
    opengl = {
      enable = true;
      extraPackages = with pkgs; [ amdvlk ];
      driSupport = true;
      driSupport32Bit = true;
    };
  };

  system.stateVersion = "22.05";
}
#########################################

#   nixpkgs = {
#     overlays = [
#       outputs.overlays.modifications
#       outputs.overlays.additions
#
#       neovim-nightly-overlay.overlays.default
#     ];
#     config = {
#       allowUnfree = true;
#       allowBroken = true;
#     };
#   };
#
#   nix = {
#     # This will add each flake input as a registry
#     # To make nix3 commands consistent with your flake
#     registry = lib.mapAttrs (_: value: { flake = value; }) inputs;
#
#     # This will additionally add your inputs to the system's legacy channels
#     # Making legacy nix commands consistent as well, awesome!
#     nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;
#
#     settings = {
#       # Enable flakes and new 'nix' command
#       experimental-features = "nix-command flakes";
#       # Deduplicate and optimize nix store
#       auto-optimise-store = true;
#     };
#
#     gc = {
#       automatic = true;
#       dates = "weekly";
#       options = "--delete-older-than 7d";
#     };
#
#     extraOptions = ''
#       experimental-features = nix-command flakes
#       warn-dirty = false
#     '';
#   };
#
#   networking = {
#     hostName = "tp_t14";
#     networkmanager.enable = true;
#   };
#
#   time.timeZone = "Europe/Amsterdam";
#
#   i18n.defaultLocale = "en_US.UTF-8";
#   console = {
#     font = "Lat2-Terminus16";
#     useXkbConfig = true;
#   };
#
#   security = {
#     polkit.enable = true; # required to setup sway with HomeManager
#     pam.services.swaylock = {
#       text = "auth include login";
#     };
#   };
#
#   services = {
#     blueman.enable = true;
#     openssh.enable = true;
#     pcscd.enable = true;
#
#     logind = {
#       lidSwitch = "suspend";
#       lidSwitchExternalPower = "lock";
#     };
#
#     xserver = {
#       enable = true;
#       libinput = {
#         enable = true; # enable touchpad
#         touchpad = {
#           disableWhileTyping = true;
#           naturalScrolling = true;
#         };
#       };
#       desktopManager = {
#         xterm.enable = false;
#         xfce.enable = true;
#       };
#       videoDrivers = [
#         "displaylink"
#         "modsetting"
#       ];
#       displayManager = {
#         sessionCommands = ''
#           ${lib.getBin pkgs.xorg.xrandr}/bin/xrandr --setprovideroutputsource 2 0
#         '';
#       };
#       layout = "us,de";
#       xkbOptions = "grp:alt_space_toggle,altwin:swap_alt_win";
#     };
#
#     # TODO
#     # jack = {
#     #   jackd.enable = true;
#     #   alsa.enable = false;
#     #   loopback = {
#     #     enable = true;
#     #   };
#     # };
#
#     # TODO
#     # kmonad = {
#     #   enable = false;
#       # configfiles = [ ../home/kmonad/config.kbd ];
#     # };
#   };
#
#   systemd.services = {
#     keyd = {
#       description = "key remapping daemon";
#       requires = [ "local-fs.target" ];
#       after = [ "local-fs.target" ];
#       wantedBy = [ "sysinit.target" ];
#       unitConfig = {
#         Type = "simple";
#       };
#       serviceConfig = {
#         ExecStart = "/usr/bin/keyd";
#       };
#     };
#   };
#
#   # environment.etc = {
#   #   "keyd/default.conf".source = ../home/keyd/config/keyd/default.conf;
#   # };
#
#   # TODO
#   # fonts.fonts = with pkgs; [
#   #   font-awesome
#   #   (nerdfonts.override {
#   #     fonts = [
#   #       "Hack"
#   #     ];
#   #   })
#   # ];
#
#   nix = {
#     settings.auto-optimise-store = true;
#     gc = {
#       automatic = true;
#       dates = "weekly";
#       options = "--delete-older-than 7d";
#     };
#     package = pkgs.nixFlakes;
#     registry.nixpkgs.flake = inputs.nixpkgs;
#     extraOptions = ''
#       experimental-features = nix-command flakes
#       warn-dirty = false
#     '';
#   };
#
#   sound = {
#     enable = true;
#     mediaKeys = {
#       enable = true;
#     };
#   };
#
#   hardware = {
#     pulseaudio.enable = true;
#     bluetooth.enable = true;
#
#     opengl = {
#       enable = true;
#       driSupport = true;
#     };
#   };
#
#   xdg = {
#     portal = {
#       enable = true;
#       extraPortals = with pkgs; [
#         xdg-desktop-portal-wlr
#         xdg-desktop-portal-gtk
#       ];
#     };
#   };
#
#   environment = {
#     variables = {
#       TERMINAL = "alacritty";
#       EDITOR = "nvim";
#       VISUAL = "nvim";
#     };
#     systemPackages = with pkgs; [
#       tmux
#       git
#       curl
#       wget
#
#       ((vim_configurable.override { }).customize {
#         name = "vim";
#         vimrcConfig = {
#           packages.myplugins = with pkgs.vimPlugins; {
#             start = [ vim-nix vim-lastplace ];
#             opt = [ ];
#           };
#           customRC = ''
#             set nu
#             set relativenu
#             set incsearch
#             set nocompatible
#             backspace=indent,eol,start
#             syntax on
#           '';
#         };
#       })
#     ];
#   };
#
#   programs = {
#     light.enable = true;
#     # Try to configure with HomeManager
#     # sway.enable = true;
#   };
#
#   programs.gnupg.agent = {
#     enable = true;
#     pinentryFlavor = "gtk2";
#     enableSSHSupport = true;
#   };
#
#   system.stateVersion = "22.05";
#
#   # TODO: Configure your system-wide user settings (groups, etc), add more users as needed.
#   # users.users = {
#   #   jdsee = {
#   #     isNormalUser = true;
#   #     openssh.authorizedKeys.keys = [
#   #       # TODO: Add your SSH public key(s) here, if you plan on using SSH to connect
#   #     ];
#   #     # TODO: Be sure to add any other groups you need (such as networkmanager, audio, docker, etc)
#   #     extraGroups = [ "wheel" ];
#   #   };
#   # };
#
#   # This setups a SSH server. Very important if you're setting up a headless system.
#   # Feel free to remove if you don't need it.
#   services.openssh = {
#     enable = false;
#     # Forbid root login through SSH.
#     permitRootLogin = "no";
#     # Use keys only. Remove if you want to SSH using password (not recommended)
#     passwordAuthentication = false;
#   };
#
#   # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
#   system.stateVersion = "22.11";
# }
