{ pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.packages;

in {
  options.modules.packages = { enable = mkEnableOption "packages"; };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      # d2d applications
      discord telegram-desktop
      spotify pgadmin4 steam ncspot

      # File managers
      nemo nemo-fileroller unzip zip

      # Networking stuff
      wireshark busybox

      # Utilities
      htop
    ];
  };

  
}

