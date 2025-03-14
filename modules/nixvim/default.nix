{ pkgs, lib, config, inputs, ... }:

with lib;
let cfg = config.modules.nixvim;

in {
  options.modules.nixvim = { enable = mkEnableOption "nixvim"; };
  config = mkIf cfg.enable {
    imports = [
      inputs.nixvim.homeManagerModules.nixvim
    ];
  };
}

