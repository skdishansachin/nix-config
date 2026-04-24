{ pkgs, config, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    configType = "hyprlang";

    settings = {
      env = [
        "XCURSOR_THEME,Adwaita"
        "XCURSOR_SIZE,24"
        "HYPRCURSOR_THEME,Adwaita"
        "HYPRCURSOR_SIZE,24"
      ];

      "$Mod" = "SUPER";

      monitor = ",preferred,auto,1";

      input = {
        natural_scroll = true;

        touchpad = {
          natural_scroll = true;
        };
      };

      general = {
        gaps_in = 5;
        gaps_out = 5;
        border_size = 1;
        layout = "dwindle";

        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";
      };

      decoration = {
        rounding = 5;
        blur.enabled = false;
      };

      animations.enabled = false;

      bind = [
        "$Mod, q, killactive,"
        "$Mod, f, fullscreen,"
        "$Mod, m, exit,"
        "$Mod, v, togglefloating,"
        "$Mod, RETURN, exec, ${pkgs.alacritty}/bin/alacritty"
        "$Mod, d, exec, ${pkgs.hyprlauncher}/bin/hyprlauncher"
        "$Mod, x, exec, ${pkgs.hyprlock}/bin/hyprlock"
        "$Mod, r, exec, hyprctl reload"

        "$Mod, 1, workspace, 1"
        "$Mod, 2, workspace, 2"
        "$Mod, 3, workspace, 3"
        "$Mod, 4, workspace, 4"
        "$Mod, 5, workspace, 5"
        "$Mod, 6, workspace, 6"
        "$Mod, 7, workspace, 7"
        "$Mod, 8, workspace, 8"
        "$Mod, 9, workspace, 9"
        "$Mod, 0, workspace, 10"

        "$Mod SHIFT, 1, movetoworkspace, 1"
        "$Mod SHIFT, 2, movetoworkspace, 2"
        "$Mod SHIFT, 3, movetoworkspace, 3"
        "$Mod SHIFT, 4, movetoworkspace, 4"
        "$Mod SHIFT, 5, movetoworkspace, 5"
        "$Mod SHIFT, 6, movetoworkspace, 6"
        "$Mod SHIFT, 7, movetoworkspace, 7"
        "$Mod SHIFT, 8, movetoworkspace, 8"
        "$Mod SHIFT, 9, movetoworkspace, 9"
        "$Mod SHIFT, 0, movetoworkspace, 10"

        "$Mod SHIFT, h, movewindow, l"
        "$Mod SHIFT, j, movewindow, d"
        "$Mod SHIFT, k, movewindow, u"
        "$Mod SHIFT, l, movewindow, r"

        "$Mod, h, movefocus, l"
        "$Mod, j, movefocus, d"
        "$Mod, k, movefocus, u"
        "$Mod, l, movefocus, r"
      ];

      bindel = [
        ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ", XF86MonBrightnessUp, exec, ${pkgs.brightnessctl}/bin/brightnessctl s 5%+"
        ", XF86MonBrightnessDown, exec, ${pkgs.brightnessctl}/bin/brightnessctl s 5%-"
      ];

      bindl = [
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioPlay, exec, ${pkgs.playerctl}/bin/playerctl play-pause"
        ", XF86AudioNext, exec, ${pkgs.playerctl}/bin/playerctl next"
        ", XF86AudioPrev, exec, ${pkgs.playerctl}/bin/playerctl previous"
      ];

      exec-once = [
        "hyprpaper"
        "${pkgs.alacritty}/bin/alacritty"
        "${pkgs.hyprlauncher}/bin/hyprlauncher -d"
      ];
    };
  };

  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
      preload = [ "${config.home.homeDirectory}/Pictures/wallpapers/wallpaper.jpg" ];
      wallpaper = [
        {
          monitor = "eDP-1";
          path = "${config.home.homeDirectory}/Pictures/wallpapers/wallpaper.jpg";
        }
      ];
    };
  };

}
