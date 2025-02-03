{ config, lib, inputs, ... }:

{
  imports = [ ../../modules/default.nix ];
  config.modules = {
    # gui
    firefox.enable = true;
    vscode.enable = true;
    hyprland.enable = true;
    hyprlock.enable = true;    
    waybar.enable = true;
    ghostty.enable = true;
 
    # cli
    git.enable = true;
    zsh.enable = true;

    # packages
    packages.enable = true;
  };

}
