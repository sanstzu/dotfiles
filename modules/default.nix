{ inputs, pkgs, config, ... }:

{
  home.stateVersion = "25.05";
  imports = [
    ./firefox
    ./vscode
    ./waybar
    ./ghostty
    ./wofi
    ./neovim

    # System
    ./kanshi
    ./hypridle
    ./hyprland
    ./hyprlock

    ./git
    ./zsh

    ./packages
    ./dev-packages
  ];
}
