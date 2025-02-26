{ inputs, pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    sbctl systemdUkify
  ];

  boot.loader.systemd-boot.enable = lib.mkForce false;
  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/var/lib/sbctl";
  };
}
