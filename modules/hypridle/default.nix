{ pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.hypridle;

in {
  options.modules.hypridle = { enable = mkEnableOption "hypridle"; };
  config = mkIf cfg.enable {
    services.hypridle = {
      enable = true;
      settings = {
        general = {
          lock_cmd = "pidof hyprlock || hyprlock";      # avoid starting multiple hyprlock instances.
        };
        listener = [
          {
              timeout = 150;                                # 2.5min.
              on-timeout = "brightnessctl -s set 10";        # set monitor backlight to minimum, avoid 0 on OLED monitor.
              on-resume = "brightnessctl -r";                 # monitor backlight restore.
          }
          {
              timeout = 300;                                    # 5min
              on-timeout = "loginctl lock-session";            # lock screen when timeout has passed
          }
        ];
      };
    };
  };
}

