{ pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.hyprlock;

in {
  options.modules.hyprlock = { enable = mkEnableOption "hyprlock"; };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      hyprlock
    ];

    programs.hyprlock = {
      enable = true;
      settings = {
        
        "$rosewater" = "rgb(f2d5cf)";
        "$rosewaterAlpha" = "f2d5cf";

        "$flamingo" = "rgb(eebebe)";
        "$flamingoAlpha" = "eebebe";

        "$pink" = "rgb(f4b8e4)";
        "$pinkAlpha" = "f4b8e4";

        "$mauve" = "rgb(ca9ee6)";
        "$mauveAlpha" = "ca9ee6";

        "$red" = "rgb(e78284)";
        "$redAlpha" = "e78284";

        "$maroon" = "rgb(ea999c)";
        "$maroonAlpha" = "ea999c";

        "$peach" = "rgb(ef9f76)";
        "$peachAlpha" = "ef9f76";

        "$yellow" = "rgb(e5c890)";
        "$yellowAlpha" = "e5c890";

        "$green" = "rgb(a6d189)";
        "$greenAlpha" = "a6d189";

        "$teal" = "rgb(81c8be)";
        "$tealAlpha" = "81c8be";

        "$sky" = "rgb(99d1db)";
        "$skyAlpha" = "99d1db";

        "$sapphire" = "rgb(85c1dc)";
        "$sapphireAlpha" = "85c1dc";

        "$blue" = "rgb(8caaee)";
        "$blueAlpha" = "8caaee";

        "$lavender" = "rgb(babbf1)";
        "$lavenderAlpha" = "babbf1";

        "$text" = "rgb(fafafa)  #rgb(c6d0f5)";
        "$textAlpha" = "fafafa #c6d0f5";

        "$subtext1" = "rgb(b5bfe2)";
        "$subtext1Alpha" = "b5bfe2";

        "$subtext0" = "rgb(a5adce)";
        "$subtext0Alpha" = "a5adce";

        "$overlay2" = "rgb(949cbb)";
        "$overlay2Alpha" = "949cbb";

        "$overlay1" = "rgb(838ba7)";
        "$overlay1Alpha" = "838ba7";

        "$overlay0" = "rgb(737994)";
        "$overlay0Alpha" = "737994";

        "$surface2" = "rgb(626880)";
        "$surface2Alpha" = "626880";

        "$surface1" = "rgb(51576d)";
        "$surface1Alpha" = "51576d";

        "$surface0" = "rgb(414559)";
        "$surface0Alpha" = "414559";

        "$base" = "rgb(303446)";
        "$baseAlpha" = "303446";

        "$mantle" = "rgb(292c3c)";
        "$mantleAlpha" = "292c3c";

        "$crust" = "rgb(232634)";
        "$crustAlpha" = "232634";

        "$accent" = "$mantle";
        "$accentAlpha" = "$mantleAlpha";
        "$font" = "JetBrainsMono Nerd Font";

        general =  {
          disable_loading_bar = true;
          hide_cursor = true;
        };

        # BACKGROUND
        background = lib.mkForce {
          monitor = "";
          path = "$HOME/.config/hypr/background";
          blur_passes = 0;
          color = "$base";
        };

        # LAYOUT
        label = [

          # LAYOUT
          {
            monitor = "";
            text = "Layout: $LAYOUT";
            color = "$text";
            font_size = "15";
            font_family = "$font";
            position = "30, -30";
            halign = "left";
            valign = "top";
          }

          # TIME
          {
            monitor = "";
            text = "$TIME";
            color = "$text";
            font_size = "90";
            font_family = "$font";
            position = "-30, 0";
            halign = "right";
            valign = "top";
          }

          # DATE
          {
            monitor = "";
            text = "cmd[update:43200000] date +\"%A, %d %B %Y\"";
            color = "$text";
            font_size = 25;
            font_family = "$font";
            position = "-30, -150";
            halign = "right";
            valign = "top";
          }
        ];

        # USER AVATAR
        image = {
          monitor = "";
          path = "$HOME/.face";
          size = "100";
          border_color = "$accent";
          position = "0, 75";
          halign = "center";
          valign = "center";
        };

        # INPUT FIELD
        input-field = lib.mkForce {
            monitor = "";
            size = "300, 60";
            outline_thickness = "4";
            dots_size = "0.2";
            dots_spacing = "0.2";
            dots_center = "true";
            outer_color = "$accent";
            inner_color = "$surface0";
            font_color = "$text";
            hide_input = false;
            check_color = "$accent";
            fail_color = "$red";
            fail_text = "<i>$FAIL <b>($ATTEMPTS)</b></i>";
            capslock_color = "$yellow";
            position = "0, -47";
            halign = "center";
            valign = "center";
          };
      };
    };
    
    home.file.".config/hypr/background".source = ./background;
    
  };
}

