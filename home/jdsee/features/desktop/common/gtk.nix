{ config, pkgs, inputs, ... }:

{
  gtk = {
    enable = true;
    font = {
      name = config.fontProfiles.regular.family;
      size = 12;
    };

    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };

    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };

    theme = {
      # name = "Orchis-Grey-Dark-Compact";
      # package = pkgs.orchis-theme;

      name = "Colloid-Dark";
      package = pkgs.colloid-gtk-theme;

      # name = "Vertex-Dark";
      # package = pkgs.theme-vertex;
    };

    iconTheme = {
      name = "Papirus";
      package = pkgs.papirus-icon-theme;
    };
  };

  services.xsettingsd = {
    enable = true;
    settings = {
      # "Net/ThemeName" = "${gtk.theme.name}";
      # "Net/IconThemeName" = "${gtk.iconTheme.name}";
    };
  };
}
