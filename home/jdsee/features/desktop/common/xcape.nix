{ pkgs, lib, outputs, ... }:
{
  services.xcape = {
    enable = true;
    mapExpression = {
      Control_L = "Control_L|Escape";
    };
  };
}
