{ pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.git;

in {
  options.modules.git = { enable = mkEnableOption "git"; };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      git-credential-manager
    ];

    programs.git = {
      enable = true;
      userName = "Clayton Fernalo";
      userEmail = "claytonfernalo@gmail.com";
      extraConfig = {
        init = { defaultBranch = "main"; };
        credential.credentialStore = gpg;
      };
    };
  };
}

