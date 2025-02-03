{ pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.waybar;

in {
  options.modules.waybar = { enable = mkEnableOption "waybar"; };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      jq waybar wlsunset wl-clipboard mako pavucontrol playerctl wlogout playerctl waybar-mpris brightnessctl
    ];

    programs.waybar = {
      enable = true;
    };
    
    home.file.".config/waybar" = {
      source = ./config;
      recursive = true; 
    }; 
  };

}
