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
      # profiles = {
      #   default = {
      #     extensions = with pkgs; [
      #       vscode-extensions.ocamllabs.ocaml-platform
      #       vscode-extensions.rust-lang.rust-analyzer
      #       vscode-extensions.golang.go
      #       vscode-extensions.dbaeumer.vscode-eslint
      #     ];
      #   };
      # };
    };


  };
}

