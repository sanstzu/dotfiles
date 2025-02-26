nixos-hardware:
{ inputs, ... }:

{
  imports = [
    inputs.nixos-hardware.nixosModules.asus-zephyrus-ga401
    inputs.lanzaboote.nixosModules.lanzaboote
    ./hardware-configuration.nix
    ./nvidia.nix
    ./lanzaboote.nix
  ];
}
