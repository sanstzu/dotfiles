{ inputs, ... }:

{
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;
    
    powerManagement.enable = false;
    nvidiaSettings = true;
    forceFullCompositionPipeline = false;
  };
}
