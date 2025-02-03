nixos-hardware:
{ inputs, ... }:

{
  imports = [
    inputs.nixos-hardware.nixosModules.asus-zephyrus-ga401
    ./hardware-configuration.nix
    ./nvidia.nix
  ];
}
