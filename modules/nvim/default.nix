{ pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.nvim;

in {
  options.modules.nvim = { enable = mkEnableOption "nvim"; };
  config = mkIf cfg.enable {
    home.pkgs = with pkgs; [
      nvim
    ];

    
    home.file.".config/nvim".source = builtins.fetchGit {
      url = "https://github.com/LazyVim/starter.git";
      rev = "803bc181d7c0d6d5eeba9274d9be49b287294d99";
    };
  };
}

