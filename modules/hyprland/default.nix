{ pkgs, lib, config, inputs, ... }:

with lib;
let cfg = config.modules.hyprland;

in {
  options.modules.hyprland = { enable = mkEnableOption "hyprland"; };
  
  config = mkIf cfg.enable {

    home.packages = with pkgs; [
      gtk3 hyprland swaybg wofi dolphin
    ];

    # home.file.".config/hypr/hyprland.conf".source = ./hyprland.conf;
    wayland.windowManager.hyprland = {
      enable = true;
      systemd.enable = false;
      extraConfig = ''
        ${builtins.readFile ./hyprland.conf}  
      '';
    };
  };
}

