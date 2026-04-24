{ pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      nerd-fonts.iosevka
      inter
    ];

    pointerCursor = {
      gtk.enable = true;
      package = pkgs.adwaita-icon-theme;
      name = "Adwaita";
      size = 24;
    };
  };

  gtk = {
    enable = true;

    cursorTheme = {
      package = pkgs.adwaita-icon-theme;
      name = "Adwaita";
    };

    font = {
      name = "Inter";
      size = 10;
    };
  };

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      monospace = [ "Iosevka Nerd Font" ];
      sansSerif = [ "Inter" ];
      serif = [ "Inter" ];
    };
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      font-name = "Inter 10";
      document-font-name = "Inter 10";
      monospace-font-name = "Iosevka Nerd Font 10";
    };
  };
}
