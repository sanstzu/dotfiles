{ pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.vscode;

in {
  options.modules.vscode = { enable = mkEnableOption "vscode"; };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      vscode.fhs
    ];
    
    programs.vscode = {
      enable = true;
      package = pkgs.vscode.fhs;
      mutableExtensionsDir = false;
      userSettings = {
       editor.fontFamily = "'JetBrainsMono Nerd Font'";
      };
    };


  };
}

