{ inputs, lib, pkgs, config, outputs, ... }:

{
  nix = {
    settings = {
      experimental-features = [
        "nix-command"
      ];
    };
  };

  programs.zsh = {
    profileExtra = ''
      export DEVBOX_HOST_ADDRESS="$(netsh.exe interface ip show address "vEthernet (WSL)" | grep IP | awk '{print $3}')"
    '';
  };
}
