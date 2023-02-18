{ outputs, config, lib, pkgs, ... }:

let
  # Dependencies
  jq = "${pkgs.jq}/bin/jq";
  xml = "${pkgs.xmlstarlet}/bin/xml";
  systemctl = "${pkgs.systemd}/bin/systemctl";
  journalctl = "${pkgs.systemd}/bin/journalctl";
  playerctl = "${pkgs.playerctl}/bin/playerctl";
  playerctld = "${pkgs.playerctl}/bin/playerctld";
  pavucontrol = "${pkgs.pavucontrol}/bin/pavucontrol";
  btm = "${pkgs.bottom}/bin/btm";
  wofi = "${pkgs.wofi}/bin/wofi";

  terminal = "${pkgs.kitty}/bin/kitty";
  terminal-spawn = cmd: "${terminal} $SHELL -i -c ${cmd}";
  systemMonitor = terminal-spawn btm;

  # Function to simplify making waybar outputs
  jsonOutput = name: { pre ? "", text ? "", tooltip ? "", alt ? "", class ? "", percentage ? "" }: "${pkgs.writeShellScriptBin "waybar-${name}" ''
    set -euo pipefail
    ${pre}
    ${jq} -cn \
      --arg text "${text}" \
      --arg tooltip "${tooltip}" \
      --arg alt "${alt}" \
      --arg class "${class}" \
      --arg percentage "${percentage}" \
      '{text:$text,tooltip:$tooltip,alt:$alt,class:$class,percentage:$percentage}'
  ''}/bin/waybar-${name}";
in
{
  programs.waybar = {
    enable = true;
    settings = {
      primary = {
        layer = "top";
        position = "top";
        height = 30;

        modules-left = [
          "sway/workspaces"
          "sway/mode"
        ];

        modules-center = [
          "sway/window"
        ];

        modules-right = [
          "network"
          "memory"
          "cpu"
          "temperature"
          "custom/keyboard-layout"
          "battery"
          "tray"
          "clock#date"
          "clock#time"
        ];


        # -------------------------------------------------------------------------
        # Modules
        # -------------------------------------------------------------------------

        battery = {
          interval = 10;
          states = {
            warning = 30;
            critical = 15;
          };
          format = "  { icon }  {capacity}%";
          format-discharging = "{icon}  {capacity}%";
          format-icons = [ "" "" "" "" "" ];
          tooltip = true;
        };

        "clock#time" = {
          interval = 1;
          format = "{:%H:%M:%S}";
          tooltip = false;
        };

        "clock#date" = {
          interval = 10;
          format = "  {:%e %b %Y}";
          tooltip-format = "{:%e %B %Y}";
        };

        cpu = {
          interval = 5;
          format = "  {usage}% ({load})";
          states = {
            warning = 70;
            critical = 90;
          };
        };

        "custom/keyboard-layout" = {
          exec = "swaymsg -t get_inputs | grep -m1 'xkb_active_layout_name' | cut -d '\"' -f4";
          interval = 30;
          format = "  {}";
          signal = 1;
          tooltip = false;
        };

        memory = {
          interval = 5;
          format = "  {}%";
          states = {
            warning = 70;
            critical = 90;
          };
        };

        network = {
          interval = 5;
          format-wifi = "  {essid} ({signalStrength}%)";
          format-ethernet = "  {ifname}: {ipaddr}/{cidr}";
          format-disconnected = "⚠  Disconnected";
          tooltip-format = "{ifname}: {ipaddr}";
        };

        "sway/mode" = {
          format = "<span style=\"italic\">  {}</span>";
          tooltip = false;
        };

        "sway/window" = {
          format = "{}";
          max-length = 120;
        };

        "sway/workspaces" = {
          all-outputs = false;
          disable-scroll = true;
          format = "{icon} {name}";
          format-icons = {
            "1:www" = "龜";
            "2:mail" = "";
            "3:editor" = "";
            "4:terminals" = "";
            "5:portal" = "";
            urgent = "";
            focused = "";
            default = "";
          };
        };

        pulseaudio = {
          scroll-step = 1;
          format = "{icon}  {volume}%";
          format-bluetooth = "{icon}  {volume}%";
          format-muted = "";
          format-icons = {
            headphones = "";
            handsfree = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = [ "" "" ];
          };
          on-click = "pavucontrol";
        };

        temperature = {
          critical-threshold = 80;
          interval = 5;
          format = "{icon}  {temperatureC}°C";
          format-icons = [ "" "" "" "" "" ];
          tooltip = true;
        };

        tray = {
          icon-size = 21;
          spacing = 10;
        };
      };

      # style = (builtins.readFile ./style.css);
    };
  };
}



