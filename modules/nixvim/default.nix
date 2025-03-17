{ pkgs, lib, config, inputs, ... }:

with lib;
let cfg = config.modules.nixvim;

in {
  options.modules.nixvim = { enable = mkEnableOption "nixvim"; };
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
  ];

  config = mkIf cfg.enable {
    programs.nixvim = {
      enable = true;

      colorschemes.catppuccin.enable = true;
      plugins.lualine.enable = true;
    };
  };
}

