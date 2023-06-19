{ pkgs, ... }:
{
  home.sessionVariables = {
    TERMINAL = "foot";
  };
 
  programs.foot = {
    enable = true;
    settings = {
      main = {
        title = "Foot";
        term = "foot";

        font = "Hack Nerd Font Mono:size=10";
        dpi-aware = "yes";
      };

      mouse = {
        hide-when-typing = "yes";
      };

      text-bindings = {
        "\\x1b[105;5u" = "Control+i";
      };
    };
  };
}
