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

    ./git
    ./zsh

    ./packages
  ];
}
