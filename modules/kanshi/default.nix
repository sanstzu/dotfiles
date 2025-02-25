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
              # Enable my personal monitor
              criteria = "Acer Technologies CBL272U 0x2101C841";
              status = "enable";
            }
            {
              # Disable laptop screen
              criteria = "eDP-1";
              status = "disable";
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

        docked = {
          outputs = [
            {
              # Enable monitor
              criteria = "*";
              status = "enable";
            }
            {
              # Enable laptop screen (just to be safe :))
              criteria = "eDP-1";
              status = "enable";
            }
          ];
        };
      };
    };
  };
}

