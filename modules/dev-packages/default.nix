{ pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.dev-packages;

in {
  options.modules.dev-packages = { enable = mkEnableOption "dev-packages"; };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      # Rust
      rustc rustup

      # OCaml
      ocaml opam
    
      # Go
      go

      # JS/TS
      pnpm nodejs_23

      # C/C++
      gnat
    ];
  };

  
}

