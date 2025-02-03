{ pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.hypridle;

in {
  options.modules.hypridle = { enable = mkEnableOption "hypridle"; };
  config = mkIf cfg.enable {
  };
}

