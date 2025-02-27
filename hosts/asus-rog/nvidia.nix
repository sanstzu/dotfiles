{ inputs, ... }:

{
  services.xserver.videoDrivers = [ "amdgpu" "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;
    
    powerManagement = {
      enable = true;
      finegrained = true;
    };
    
    nvidiaSettings = true;
    forceFullCompositionPipeline = false;


  };
}
