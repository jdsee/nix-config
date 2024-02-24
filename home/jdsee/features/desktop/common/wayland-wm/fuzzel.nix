{ pkgs, ... }:
{
  home.packages = with pkgs; [
    bemoji
  ];
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        terminal = "${pkgs.foot}/bin/foot";
        layer = "overlay";
        # colors.background = "282a36fa";
        # colors.selection = "3d4474fa";
        # colors.border = "fffffffa";
      };
    };
  };
}
