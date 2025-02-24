{ inputs, pkgs, config, ... }:

{
  home.stateVersion = "25.05";
  imports = [
    ./firefox
    ./vscode
    ./hypridle
    ./hyprland
    ./hyprlock
    ./waybar
    ./ghostty
    ./wofi

    ./git
    ./zsh

    ./packages
    ./dev-packages
  ];
}
