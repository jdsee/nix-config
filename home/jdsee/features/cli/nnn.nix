{ pkgs, ... }:
{
  programs.nnn = {
    enable = true;
    bookmarks = {
      c = "~/nix-config";
      p = "~/projects";
      d = "~/Downloads";
    };
    plugins = {
      # TODO: Consider to add plugins with some mappings for them
      mappings = {
        c = "fzcd";
        f = "finder";
        v = "imgview";
      };
    };
  };
}
