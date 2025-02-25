{ pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.kanshi;

in {
  options.modules.kanshi = { enable = mkEnableOption "kanshi"; };
  config = mkIf cfg.enable {
    services.kanshi = {
      enable = true;

      profiles = {
        docked-hall = {
          outputs = [
            {
              # Disable laptop screen
              criteria = "eDP-1";
              status = "disable";
            }
            {
              # Enable Acer monitor
              criteria = "desc:Acer Technologies CBL272U 0x2101C841";
              status = "enable";
              mode = "2560x1440@75.00";
            }
          ];
        };
        undocked = {
          outputs = [
            {
              # Enable laptop screen
              criteria = "eDP-1";
              status = "enable";
            }
          ];
        };
      };
    };
  };
}

