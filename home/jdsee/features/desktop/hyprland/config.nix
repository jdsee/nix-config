{ pkgs, ... }:
let
  rofi = "${pkgs.rofi-wayland}/bin/rofi";
  waybar = "${pkgs.waybar}/bin/waybar";
  firefox = "${pkgs.firefox}/bin/firefox";
  kanshi = "${pkgs.kanshi}/bin/kanshi";
  signal = "${pkgs.signal-desktop}/bin/signal-desktop";
  bemoji = "${pkgs.bemoji}/bin/bemoji";
  rofi-power-menu = "${pkgs.rofi-power-menu}/bin/rofi-power-menu";
  powermenu = "${rofi} -show pm -modi pm:${rofi-power-menu}";
  fileBrowser = "${pkgs.yazi}/bin/yazi";
  terminal = "${pkgs.foot}/bin/foot";
  grim = "${pkgs.grim}/bin/grim";
  slurp = "${pkgs.slurp}/bin/slurp";
  hyprlock = "${pkgs.hyprlock}/bin/hyprlock";
  hypridle = "${pkgs.hypridle}/bin/hypridle";
  hyprpaper = "${pkgs.hyprpaper}/bin/hyprpaper";
  # annotateScreenshot = "${pkgs.satty}/bin/satty --filename - --init-tool blur --output-filename ~/Screenshots/screenshot-$(date '+%Y%m%d-%H:%M:%S').png";
  annotateScreenshot = "${pkgs.swappy}/bin/swappy -f -";
in
''
  # >>> NVIDIA specific

  env = LIBVA_DRIVER_NAME, nvidia
  env = XDG_SESSION_TYPE, wayland
  env = __GLX_VENDOR_LIBRARY_NAME, nvidia
  env = WLR_NO_HARDWARE_CURSORS, 1
  env = GBM_BACKEND, nvidia-drm

  # Use this after Hyprland update
  # cursor {
  #   no_hardware_cursors = true
  # }

  opengl {
    nvidia_anti_flicker = false
  }

  # <<< NVIDIA specific


  ## Home Setup
  # monitor = eDP-1, disabled
  # monitor = desc:Dell Inc. DELL P2719H J9T8193, preferred, auto, 1, transform, 1
  monitor = desc:Dell Inc. DELL U3219Q 8P7R413, preferred, auto, 1

  monitor=, preferred, auto, auto

  # STARTUP
  exec-once=/home/jdsee/.config/hypr/./clean_start_xdg_desktop_portal_hyprland.sh
  exec-once=${waybar} && ${waybar}
  exec-once=${hypridle} && ${hypridle}
  exec-once=${hyprpaper} && ${hyprpaper}
  exec-once=${kanshi} && ${kanshi}
  exec-once=${signal} && ${signal}
  exec-once = blueman-applet && blueman-applet
  exec-once = nm-applet && nm-applet --indicator
  exec-once = element-desktop && element-desktop

  # DEFAULT APPS
  exec-once = command -v signal-desktop && signal-desktop
  exec-once = command -v ${terminal} && ${terminal} --app-id main-term -e tmuxinator me
  # exec-once = command -v ${firefox} && ${firefox}
  exec-once = command -v thunderbird && thunderbird

  # WORKSPACE RULES

  # TODO: Setup workspaces with https://github.com/emersion/kanshi

  # primary
  workspace = 1, monitor:desc:Dell Inc. DELL U3219Q 8P7R413
  workspace = 2, monitor:desc:Dell Inc. DELL U3219Q 8P7R413
  workspace = 3, monitor:desc:Dell Inc. DELL U3219Q 8P7R413
  workspace = 4, monitor:desc:Dell Inc. DELL U3219Q 8P7R413
  workspace = 5, monitor:desc:Dell Inc. DELL U3219Q 8P7R413
  workspace = 6, monitor:desc:Dell Inc. DELL U3219Q 8P7R413
  workspace = 7, monitor:desc:Dell Inc. DELL U3219Q 8P7R413

  # secondary
  workspace = 8, monitor:desc:Dell Inc. DELL P2719H J9T8193
  workspace = 9, monitor:desc:Dell Inc. DELL P2719H J9T8193
  workspace = 0, monitor:desc:Dell Inc. DELL P2719H J9T8193

  workspace = w[0-9], persistent

  # WINDOW RULES
 
  windowrulev2 = opaque, fullscreen:1
  windowrulev2 = bordercolor rgb(F9E2AF)  rgb(009FBD) rgb(4A249D) 60deg, fullscreen:1

  windowrule = float,^(Rofi)$
  windowrule = dimaround,^(Rofi)$
  windowrule = center,^(Rofi)$

  windowrule = opacity 0.9,^(foot|main-term)$
  windowrule = opacity 0.85,^(org.pwmt.zathura)$

  windowrulev2 = float, title:^Bluetooth Devices$
  windowrulev2 = size 50% 70%, title:^Bluetooth Devices$
  windowrulev2 = center, title:^Bluetooth Devices$

  windowrulev2 = float, class:^(nm-connection-editor)$

  # windowrulev2 = workspace 3 silent, class:^(firefox)$
  windowrulev2 = workspace 4 silent, class:^(Signal)$
  windowrulev2 = workspace 5 silent, class:^(thunderbird)$
  windowrulev2 = workspace 2,        class:^(main-term)$

  # This is needed for Zotero to show dropdown menus properly
  windowrulev2 = float, class:^(Zotero*)
  windowrulev2 = windowdance, class:^(Zotero*)
  #windowrulev2 = forceinput, class:^(Zotero*)
  #windowrulev2 = nofocus, class:^(Zotero*)

  # -- Fix odd behaviors in IntelliJ IDEs --
  #! Fix focus issues when dialogs are opened or closed
  windowrulev2 = windowdance, class:^(jetbrains-.*)$,floating:1
  #! Fix splash screen showing in weird places and prevent annoying focus takeovers
  windowrulev2 = center, class:^(jetbrains-.*)$,title:^(splash)$,floating:1
  windowrulev2 = nofocus, class:^(jetbrains-.*)$,title:^(splash)$,floating:1
  windowrulev2 = noborder, class:^(jetbrains-.*)$,title:^(splash)$,floating:1

  #! Center popups/find windows
  windowrulev2 = center, class:^(jetbrains-.*)$,title:^( )$,floating:1
  windowrulev2 = stayfocused, class:^(jetbrains-.*)$,title:^( )$,floating:1
  windowrulev2 = noborder, class:^(jetbrains-.*)$,title:^( )$,floating:1
  #! Disable window flicker when autocomplete or tooltips appear
  windowrulev2 = nofocus, class:^(jetbrains-.*)$,title:^(win.*)$,floating:1

  # Disable/Enable builtin screen when lid closed/opened
  bindl = , switch:off:Lid Switch, exec, hyprctl keyword monitor "eDP-1, preferred, auto, 1"
  bindl = , switch:on:Lid Switch, exec, ~/.config/hypr/disable_internal_monitor.sh
  bindl = , switch:on:Lid Switch, exec, ${hyprpaper} # Restart hyprpaper since it crashes when disabling eDP-1

  # SETTINGS

  general {
    gaps_in = 5
    gaps_out = 10
    border_size = 2
    col.active_border = rgb(6d3e62) rgb(ec6e47) rgba(ee8c52ee) 60deg
    col.inactive_border = rgba(595959aa)
    cursor_inactive_timeout = 0
    allow_tearing = false
  }

  decoration {
    active_opacity = 1
    inactive_opacity = 1.0
    fullscreen_opacity = 1.0
    rounding = 5
    drop_shadow = true
    shadow_range = 12
    shadow_offset = 3 3
    col.shadow = 0x44000000
    col.shadow_inactive = 0x66000000
    dim_special = 0.4
  }

  animations {
    enabled = true

    bezier = easein, 0.11, 0, 0.5, 0
    bezier = easeout, 0.5, 1, 0.89, 1
    bezier = easeinout, 0.45, 0, 0.55, 1

    animation = windowsIn, 1,3, easeout, slide
    animation = windowsOut, 1,3, easein, slide
    animation = windowsMove, 1,3, easeout

    animation = fadeIn, 1,3, easeout
    animation = fadeOut, 1,3, easein
    animation = fadeSwitch, 1,3, easeout
    animation = fadeShadow, 1,3, easeout
    animation = fadeDim, 1,3, easeout
    animation = border, 1,3, easeout

    animation = workspaces, 1,2, easeout, slide
  }

  dwindle {
    split_width_multiplier = 1.35
    no_gaps_when_only = false
  }

  misc {
    # no_vfr = false
  }

  xwayland {
    force_zero_scaling = true
  }

  input {
    kb_layout = us, de
    natural_scroll = true
    kb_options = ctrl:nocaps, grp:alt_space_toggle, altwin:swap_alt_win, shift:both_capslock_cancel
    touchpad {
      natural_scroll = true
      disable_while_typing = true
      tap-to-click = true
      clickfinger_behavior = true
    }
  }

  gestures {
    workspace_swipe = true
  }

  binde = SUPER SHIFT ALT, h, resizeactive, -20 0
  binde = SUPER SHIFT ALT, j, resizeactive, 0 20
  binde = SUPER SHIFT ALT, k, resizeactive, 0 -20
  binde = SUPER SHIFT ALT, l, resizeactive, 20 0

  # Mouse binding
  bindm = SUPER, mouse:272, movewindow
  bindm = SUPER, mouse:273, resizewindow

  # Program bindings
  bind = SUPER, Return, exec,${terminal} -e tmux
  bind = SUPER, d, exec, swaync-client -d -sw
  bind = SUPER, b, exec, ${firefox}
  bind = SUPER, i, exec, ${terminal} -e nvim
  bind = SUPER, y, exec, ${terminal} -e yazi

  bind = SUPER, space, exec,${rofi} -show drun
  bind = SUPER, escape, exec,${powermenu}
  bind = ALT CONTROL, space, exec,${rofi} -show combi
  bind = SUPER CONTROL, s,exec,${rofi} -show ssh
  bind = SUPER CONTROL, space, exec, rofi-pass
  bind = SUPER CONTROL, b,exec, rofi-bluetooth
  bind = SHIFT SUPER, e,exec,${bemoji} -t

  # Toggle waybar
  bind = SUPER, a, exec, pkill -USR1 waybar

  # Lock screen
  bind = SUPER ALT, l, exec, hyprlock

  # Screenshots
  bind = SUPER SHIFT, s, exec, ${grim} -g "$(${slurp} -o -r -c '40E0D0')" - | ${annotateScreenshot}
  bind = SUPER SHIFT CONTROL, s, exec, ${grim} -g "$(${slurp} -c '40E0D0')" - | ${annotateScreenshot}
  # Keyboard controls (brightness, media, sound, etc)
  bind=,XF86MonBrightnessUp, exec, light -A 10
  bind=,XF86MonBrightnessDown, exec, light -U 10

  bind=,XF86AudioNext, exec, playerctl next
  bind=,XF86AudioPrev, exec, playerctl previous
  bind=,XF86AudioPlay, exec, playerctl play-pause
  bind=,XF86AudioStop, exec, playerctl stop
  bind = ALT, XF86AudioNext, exec, playerctld shift
  bind = ALT, XF86AudioPrev, exec, playerctld unshift
  bind = ALT, XF86AudioPlay, exec, systemctl --user restart playerctld
  bind = SUPER, XF86AudioPlay, exec,$TERMINAL $SHELL -ic lyrics
  bind = SUPER ALT, c,exec, hyprpicker | wl-copy

  bind=,XF86AudioRaiseVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ +5%
  bind=,XF86AudioLowerVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ -5%
  bind=,XF86AudioMute, exec, pactl set-sink-mute @DEFAULT_SINK@ toggle

  bind = SHIFT, XF86AudioMute, exec, pactl set-source-mute @DEFAULT_SOURCE@ toggle
  bind=,XF86AudioMicMute, exec, pactl set-source-mute @DEFAULT_SOURCE@ toggle


  # Window manager controls
  bind = SUPER, w,killactive
  bind = SUPERSHIFTCONTROL, e,exit
  bind = SUPERSHIFT, c,centerwindow,

  bind = SUPER, s,togglesplit
  bind = SUPER, f, fullscreen, 0
  bind = SUPER SHIFT, f, fullscreen, 1
  bind = SUPERSHIFT, space, togglefloating

  bind = SUPER, minus, splitratio,-0.25
  bind = SUPERSHIFT, minus, splitratio,-0.3333333

  bind = SUPER, equal, splitratio, 0.25
  bind = SUPERSHIFT, equal, splitratio, 0.3333333

  bind = SUPER, g,togglegroup
  bind = SUPER, apostrophe, changegroupactive, f
  bind = SUPERSHIFT, apostrophe, changegroupactive, b

  bind = SUPER, left, movefocus, l
  bind = SUPER, right, movefocus, r
  bind = SUPER, up, movefocus, u
  bind = SUPER, down, movefocus, d
  bind = SUPER, h,movefocus, l
  bind = SUPER, l,movefocus, r
  bind = SUPER, k,movefocus, u
  bind = SUPER, j,movefocus, d

  bind = SUPERSHIFT, left, movewindow, l
  bind = SUPERSHIFT, right, movewindow, r
  bind = SUPERSHIFT, up, movewindow, u
  bind = SUPERSHIFT, down, movewindow, d
  bind = SUPERSHIFT, h,movewindow, l
  bind = SUPERSHIFT, l,movewindow, r
  bind = SUPERSHIFT, k,movewindow, u
  bind = SUPERSHIFT, j,movewindow, d

  # bind = SUPERCONTROL, left, focusmonitor, l
  # bind = SUPERCONTROL, right, focusmonitor, r
  # bind = SUPERCONTROL, up, focusmonitor, u
  # bind = SUPERCONTROL, down, focusmonitor, d
  # bind = SUPERCONTROL, h,focusmonitor, l
  # bind = SUPERCONTROL, l,focusmonitor, r
  # bind = SUPERCONTROL, k,focusmonitor, u
  # bind = SUPERCONTROL, j,focusmonitor, d

  bind = SUPER, m, focusmonitor, +1
  bind = SUPERALT, m, movecurrentworkspacetomonitor, l

  bind = SUPER ALT, h, focusmonitor, l
  bind = SUPER ALT, l, focusmonitor, r

  bind = SUPERCONTROL, 1,focusmonitor, DP-1
  bind = SUPERCONTROL, 2,focusmonitor, DP-2
  bind = SUPERCONTROL, 3,focusmonitor, DP-3

  bind = SUPERCONTROLSHIFT, left, movewindow, mon:l
  bind = SUPERCONTROLSHIFT, right, movewindow, mon:r
  bind = SUPERCONTROLSHIFT, up, movewindow, mon:u
  bind = SUPERCONTROLSHIFT, down, movewindow, mon:d
  bind = SUPERCONTROLSHIFT, h,movewindow, mon:l
  bind = SUPERCONTROLSHIFT, l,movewindow, mon:r
  bind = SUPERCONTROLSHIFT, k,movewindow, mon:u
  bind = SUPERCONTROLSHIFT, j,movewindow, mon:d

  bind = SUPERCONTROLSHIFT, 1,movewindow, mon:DP-1
  bind = SUPERCONTROLSHIFT, 2,movewindow, mon:DP-2
  bind = SUPERCONTROLSHIFT, 3,movewindow, mon:DP-3

  bind = SUPERALT, left, movecurrentworkspacetomonitor, l
  bind = SUPERALT, right, movecurrentworkspacetomonitor, r
  bind = SUPERALT, up, movecurrentworkspacetomonitor, u
  bind = SUPERALT, down, movecurrentworkspacetomonitor, d
  bind = SUPERALT, h,movecurrentworkspacetomonitor, l
  bind = SUPERALT, l,movecurrentworkspacetomonitor, r
  bind = SUPERALT, k,movecurrentworkspacetomonitor, u
  bind = SUPERALT, j,movecurrentworkspacetomonitor, d

  # >>> SPECIAL WORKSPACES
  bind = SUPER, u,togglespecialworkspace, scratchpad
  bind = SUPERSHIFT, u,movetoworkspace, special:scratchpad

  # this drops a window from a special ws to the underlying one
  bind = SUPERCONTROL, u,movetoworkspace, e+0
  bind = SUPERCONTROL, u,togglespecialworkspace, explorer

  bind = SUPERCONTROL, e,exec,$TERMINAL --title=explorer -e ${fileBrowser}
  bind = SUPERCONTROL, e,exec, sleep 0.3 && hyprctl dispatch togglespecialworkspace explorer
  # TODO: find good shortcuts for special workspace stuff
  # bind = SUPERSHIFT, e,movetoworkspace, special:scratchpad
  bind = SUPER, e,togglespecialworkspace, explorer
  windowrule = workspace special:explorer, title:.*explorer

  bind = SUPERCONTROL, backspace, movetoworkspace, e+0
  bind = SUPERCONTROL, backspace, togglespecialworkspace, explorer
  # <<<

  bind = SUPERSHIFTCONTROL, l,movetoworkspace,+1
  bind = SUPERSHIFTCONTROL, h,movetoworkspace,-1

  bind = SUPERCONTROL, l, workspace, +1
  bind = SUPERCONTROL, h, workspace, -1
  bind = SUPER, o, focusurgentorlast

  # TODO
  # bind = SUPER CONTROL, m, swapactiveworkspaces, Monitor1 Monitor2
  bind = SUPER SHIFT, <, movewindow, mon:-1
  bind = SUPER SHIFT, >, movewindow, mon:+1

  bind = SUPER, 1,workspace, 01
  bind = SUPER, 2,workspace, 02
  bind = SUPER, 3,workspace, 03
  bind = SUPER, 4,workspace, 04
  bind = SUPER, 5,workspace, 05
  bind = SUPER, 6,workspace, 06
  bind = SUPER, 7,workspace, 07
  bind = SUPER, 8,workspace, 08
  bind = SUPER, 9,workspace, 09
  bind = SUPER, 0,workspace, 10
  bind = SUPER, f1, workspace, 11
  bind = SUPER, f2, workspace, 12
  bind = SUPER, f3, workspace, 13
  bind = SUPER, f4, workspace, 14
  bind = SUPER, f5, workspace, 15
  bind = SUPER, f6, workspace, 16
  bind = SUPER, f7, workspace, 17
  bind = SUPER, f8, workspace, 18
  bind = SUPER, f9, workspace, 19
  bind = SUPER, f10, workspace, 20
  bind = SUPER, f11, workspace, 21
  bind = SUPER, f12, workspace, 22

  bind = SUPERSHIFT, 1,movetoworkspacesilent, 01
  bind = SUPERSHIFT, 2,movetoworkspacesilent, 02
  bind = SUPERSHIFT, 3,movetoworkspacesilent, 03
  bind = SUPERSHIFT, 4,movetoworkspacesilent, 04
  bind = SUPERSHIFT, 5,movetoworkspacesilent, 05
  bind = SUPERSHIFT, 6,movetoworkspacesilent, 06
  bind = SUPERSHIFT, 7,movetoworkspacesilent, 07
  bind = SUPERSHIFT, 8,movetoworkspacesilent, 08
  bind = SUPERSHIFT, 9,movetoworkspacesilent, 09
  bind = SUPERSHIFT, 0,movetoworkspacesilent, 10
  bind = SUPERSHIFT, f1, movetoworkspacesilent, 11
  bind = SUPERSHIFT, f2, movetoworkspacesilent, 12
  bind = SUPERSHIFT, f3, movetoworkspacesilent, 13
  bind = SUPERSHIFT, f4, movetoworkspacesilent, 14
  bind = SUPERSHIFT, f5, movetoworkspacesilent, 15
  bind = SUPERSHIFT, f6, movetoworkspacesilent, 16
  bind = SUPERSHIFT, f7, movetoworkspacesilent, 17
  bind = SUPERSHIFT, f8, movetoworkspacesilent, 18
  bind = SUPERSHIFT, f9, movetoworkspacesilent, 19
  bind = SUPERSHIFT, f10, movetoworkspacesilent, 20
  bind = SUPERSHIFT, f11, movetoworkspacesilent, 21
  bind = SUPERSHIFT, f12, movetoworkspacesilent, 22


  blurls = waybar
''
