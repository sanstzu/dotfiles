{ inputs, ... }:

{
  imports = [
    inputs.nixos-hardware.nixosModules.asus-zephyrus-ga401
    inputs.lanzaboote.nixosModules.lanzaboote
    inputs.stylix.nixosModules.stylix
    ./hardware-configuration.nix
    ./nvidia.nix
    ./lanzaboote.nix
    ./stylix.nix
  ];
}
