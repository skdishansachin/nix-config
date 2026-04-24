{ ... }:

{
  programs.alacritty = {
    enable = true;

    theme = "xterm";

    settings = {
      font = {
        size = 14;

        normal = {
          family = "Iosevka Nerd Font Propo";
          style = "Regular";
        };
      };
    };
  };
}
