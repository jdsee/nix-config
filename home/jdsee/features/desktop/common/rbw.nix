{ pkgs, lib, outputs, ... }:

{
  programs.rbw = {
    enable = true;
    settings = {
      email = "joscha-seelig@protonmail.com";
      lock_timeout = 3600;
      pinentry = "gtk2";
    };
  };
}
