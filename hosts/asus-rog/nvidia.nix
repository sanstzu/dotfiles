{ inputs, config, ... }:

{
  services.xserver.videoDrivers = [ "amdgpu" "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;
    
    powerManagement = {
      enable = true;
      finegrained = true;
    };

    package = config.boot.kernelPackages.nvidiaPackages.production;

    nvidiaSettings = true;
    forceFullCompositionPipeline = false;
  };
}
