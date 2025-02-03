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
    };

    home.file.".config/hypr/hyprlock.conf".source = ./hyprlock.conf;
  };
}

