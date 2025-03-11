{ pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.zsh;

in {
  options.modules.zsh = { enable = mkEnableOption "zsh"; };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      zsh
    ];

    programs.zsh = {
      enable = true;
      enableCompletion = true;
      plugins = [
        {
          name = "pure";
          src = pkgs.fetchFromGitHub {
            owner = "sindresorhus";
            repo = "pure";
            rev = "v1.23.0";
            hash = "sha256-BmQO4xqd/3QnpLUitD2obVxL0UulpboT8jGNEh4ri8k=";
          };
        }
      ];
      shellAliases = {
        "nix-rbs" = "sudo nixos-rebuild switch --flake ~/.nix";
        "nix-clean" = "sudo nix-collect-garbage --delete-older-than 1d";
        "spotify" = "ncspot";
      };
    };
  };
}

