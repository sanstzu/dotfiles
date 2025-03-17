{ pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.packages;

in {
  options.modules.packages = { enable = mkEnableOption "packages"; };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      # d2d applications
      pgadmin4 steam ncspot
      libreoffice-qt6-fresh obsidian

      # Communications
      zoom-us slack discord telegram-desktop
      
      # File managers
      nemo nemo-fileroller unzip zi

      # Networking stuff
      wireshark busybox

      # System utilities
      htop ncdu pciutils

      # ??
      neofetch solaar
    ];
  };

  
}

