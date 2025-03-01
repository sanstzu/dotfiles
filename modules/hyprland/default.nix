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
    wayland.windowManager.hyprland = {
      enable = true;
      systemd.enable = false;
      extraConfig = ''
        ${builtins.readFile ./hyprland.conf}  
      '';
    };

    home.file.".comfig/uwsm/env-hyprland".text = ''
      env = AQ_DRM_DEVICES,/dev/dri/card1:/dev/dri/card0;
    '';
  };
}

