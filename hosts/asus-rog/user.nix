{ config, lib, inputs, ... }:

{
  imports = [ ../../modules/default.nix ];
  config.modules = {
    # gui
    firefox.enable = true;
    vscode.enable = true;
    ghostty.enable = true;
  

    # system
    kanshi.enable = true;
    hypridle.enable = true;  
    hyprland.enable = true;
    hyprlock.enable = true;
    waybar.enable = true;
    wofi.enable = true; 

    # cli
    git.enable = true;
    zsh.enable = true;

    # packages
    packages.enable = true;
    dev-packages.enable = true;
  };

}
