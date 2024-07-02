{ pkgs, ... }:

{
  home.packages = with pkgs; [
    kanata
  ];

  xdg.configFile = {
    "kanata-tray/kanata-tray.toml" = {
    # TODO: inline dynamic path to kanata
      text = builtins.readFile ./kanata_tray.toml;
    };

    "kanata-tray/tap_esc_hold_ctrl.conf" = {
      text = builtins.readFile ./tap_esc_hold_ctrl.conf;
    };
  };

}
