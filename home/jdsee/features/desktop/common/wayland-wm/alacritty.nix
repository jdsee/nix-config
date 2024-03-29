{ config, lib, pkgs, user, ... }:

{
  home.sessionVariables = {
    TERMINAL = "alacritty";
  };
  programs.alacritty = {
    enable = true;
    settings = {
      env.TERM = "alacritty";
      font = {
        size = 12.0;
        normal = {
          famile = "Hack Nerd Font Mono";
          style = "Regular";
        };
        bold = {
          famile = "Hack Nerd Font Mono";
          style = "Bold";
        };
        italic = {
          famile = "Hack Nerd Font Mono";
          style = "Italic";
        };
      };
      window = {
        decorations = "none";
        title = "Alacritty";
        opacity = 1;
        dynamicPadding = true;
        padding = {
          x = 0;
          y = 0;
        };
      };
      mouse = {
        hide_when_typing = true;
      };
      key_bindings = [
        { key = "I"; mods = "Control"; chars = "\e[105;5u"; }
        { key = "I"; mods = "Control|Shift"; chars = "\e[105;6u"; }

        { key = "H"; mods = "Control|Shift"; chars = "\e[72;6u"; }
        { key = "J"; mods = "Control|Shift"; chars = "\e[74;6u"; }
        { key = "K"; mods = "Control|Shift"; chars = "\e[75;6u"; }
        { key = "L"; mods = "Control|Shift"; chars = "\e[76;6u"; }

        { key = "Return"; mods = "Control"; chars = "\e[13;5u"; }
        { key = "Return"; mods = "Shift"; chars = "\e[13;2u"; }
        { key = "Period"; mods = "Control"; chars = "\e[46;5u"; }
        { key = "Comma"; mods = "Control"; chars = "\e[44;5u"; }
        { key = "Semicolon"; mods = "Control"; chars = "\e[59;5u"; }
      ];
    };
  };
}
