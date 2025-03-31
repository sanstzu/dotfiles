{ pkgs, lib, config, inputs, ... }:

with lib;
let cfg = config.modules.hyprland;

in {
  options.modules.hyprland = { enable = mkEnableOption "hyprland"; };
  
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      gtk3 hyprland swaybg networkmanagerapplet wofi hyprshot
    ];

    # home.file.".config/hypr/hyprland.conf".source = ./hyprland.conf;
    wayland.windowManager.hyprland = lib.mkForce {
      enable = true;
      systemd.enable = false;
      settings = {
        # Monitor configuration
        monitor = [
          "eDP-1, 2560x1440@120, 0x0, 1"
        ];


        # General settings
        general = {
          gaps_in = 5;
          gaps_out = 20;
          border_size = 2;
          "col.active_border" = "0xffb072d1";
          "col.inactive_border" = "0xff292a37";
          resize_on_border = false;
          allow_tearing = false;
          layout = "dwindle";
        };

        # Decoration settings
        decoration = {
          rounding = 10;
          active_opacity = 1.0;
          inactive_opacity = 1.0;

          shadow = {
            enabled = true;
            range = 4;
            render_power = 3;
            color = "rgba(1a1a1aee)";
          };

          blur = {
            enabled = true;
            size = 5;
            passes = 3;
            vibrancy = 0.1696;
          };
        };

        # Animation settings
        animations = {
          enabled = true;

          bezier = [
            "easeOutQuint,0.23,1,0.32,1"
            "easeInOutCubic,0.65,0.05,0.36,1"
            "linear,0,0,1,1"
            "almostLinear,0.5,0.5,0.75,1.0"
            "quick,0.15,0,0.1,1"
          ];

          animation = [
            "global, 1, 10, default"
            "border, 1, 5.39, easeOutQuint"
            "windows, 1, 4.79, easeOutQuint"
            "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
            "windowsOut, 1, 1.49, linear, popin 87%"
            "fadeIn, 1, 1.73, almostLinear"
            "fadeOut, 1, 1.46, almostLinear"
            "fade, 1, 3.03, quick"
            "layers, 1, 3.81, easeOutQuint"
            "layersIn, 1, 4, easeOutQuint, fade"
            "layersOut, 1, 1.5, linear, fade"
            "fadeLayersIn, 1, 1.79, almostLinear"
            "fadeLayersOut, 1, 1.39, almostLinear"
            "workspaces, 1, 1.94, almostLinear, fade"
            "workspacesIn, 1, 1.21, almostLinear, fade"
            "workspacesOut, 1, 1.94, almostLinear, fade"
          ];
        };

        # Dwindle layout settings
        dwindle = {
          pseudotile = true;
          preserve_split = true;
        };

        # Master layout settings
        master = {
          new_status = "master";
        };

        # Misc settings
        misc = {
          force_default_wallpaper = 0;
          disable_hyprland_logo = true;
          mouse_move_enables_dpms = false;
        };

        # Input settings
        input = {
          kb_layout = "us";
          follow_mouse = 1;
          sensitivity = 0;
          touchpad = {
            natural_scroll = true;
          };
        };

        # Gesture settings
        gestures = {
          workspace_swipe = false;
        };
        
        xwayland = {
          force_zero_scaling = true;
        };

        # Device-specific settings
        device = {
          name = "epic-mouse-v1";
          sensitivity = -0.5;
        };

        # Keybindings
        "$mainMod" = "SUPER";
        "$terminal" = "ghostty";
        "$fileManager" = "dolph";
        "$menu" = "wofi --show drun --width=720px --height=480 --style=$HOME/.config/wofi.css --term=footclient --prompt=Run";
        "$NIXOS_CONFIG_DIR" = "~/.nix";

        # Window and workspace rules
        bind = [
          "$mainMod, Q, exec, $terminal"
          "$mainMod, C, killactive,"
          "$mainMod, M, exit,"
          "$mainMod, E, exec, $fileManager"
          "$mainMod, V, togglefloating,"
          "$mainMod, R, exec, $menu"
          "$mainMod, P, pseudo," # dwindle
          "$mainMod, J, togglesplit," # dwindle
          "$mainMod, F, fullscreen"
          "$mainMod SHIFT, Q, exec, hyprlock" # lock

          # Move focus
          "$mainMod, left, movefocus, l"
          "$mainMod, right, movefocus, r"
          "$mainMod, up, movefocus, u"
          "$mainMod, down, movefocus, d"

          # Switch workspaces
          "$mainMod, 1, workspace, 1"
          "$mainMod, 2, workspace, 2"
          "$mainMod, 3, workspace, 3"
          "$mainMod, 4, workspace, 4"
          "$mainMod, 5, workspace, 5"
          "$mainMod, 6, workspace, 6"
          "$mainMod, 7, workspace, 7"
          "$mainMod, 8, workspace, 8"
          "$mainMod, 9, workspace, 9"
          "$mainMod, 0, workspace, 10"

          # Move window to workspace
          "$mainMod SHIFT, 1, movetoworkspace, 1"
          "$mainMod SHIFT, 2, movetoworkspace, 2"
          "$mainMod SHIFT, 3, movetoworkspace, 3"
          "$mainMod SHIFT, 4, movetoworkspace, 4"
          "$mainMod SHIFT, 5, movetoworkspace, 5"
          "$mainMod SHIFT, 6, movetoworkspace, 6"
          "$mainMod SHIFT, 7, movetoworkspace, 7"
          "$mainMod SHIFT, 8, movetoworkspace, 8"
          "$mainMod SHIFT, 9, movetoworkspace, 9"
          "$mainMod SHIFT, 0, movetoworkspace, 10"

          # Screenshot
          "$mainMod SHIFT, S, exec, hyprshot -m region --freeze --clipboard-only"
          ", PRINT, exec, hyprshot -m output --clipboard-only --silent"
        ];
        
        cursor.no_hardware_cursors = true;

        bindl = [
          ", XF86AudioNext, exec, playerctl next"
          ", XF86AudioPause, exec, playerctl play-pause"
          ", XF86AudioPlay, exec, playerctl play-pause"
          ", XF86AudioPrev, exec, playerctl previous"
        ];

        bindm = [
          "$mainMod, mouse:272, movewindow"
          "$mainMod, mouse:273, resizewindow"
        ];

        bindel = [
          ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
          ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
          ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
          ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
          ",XF86MonBrightnessUp, exec, brightnessctl s 10%+"
          ",XF86MonBrightnessDown, exec, brightnessctl s 10%-"
          ",XF86KbdBrightnessUp, exec, brightnessctl -d asus::kbd_backlight s 1+"
          ",XF86KbdBrightnessDown, exec, brightnessctl -d asus::kbd_backlight s 1-"
        ];

        # Window rules
        windowrulev2 = [
          "float, class:nm-connection-editor"
          "float, class:org.pulseaudio.pavucontrol"
          "float, class:.blueman-manager-wrapped"
          "suppressevent maximize, class:.*"
          "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
          "stayfocused, class:^jetbrains-rustrover$, title:^$"
          "move onscreen cursor, class:^jetbrains-rustrover$, title:^$"
        ];

        # Executions on start
        exec-once = [
          "swaybg -i $NIXOS_CONFIG_DIR/pics/wallpaper3.jpg"
          "waybar"
          "systemctl --user enable --now hypridle.service"
        ];
      };
    };

    home.file.".config/uwsm/env-hyprland".text = ''
      export AQ_DRM_DEVICES="/dev/dri/card1:/dev/dri/card0"
      export XCURSOR_SIZE=24
      export HYPRCURSOR_SIZE=24
      export LIBVA_DRIVER_NAME=nvidia
      export __GLX_VENDOR_LIBRARY_NAME=nvidia
    '';
  };
}

