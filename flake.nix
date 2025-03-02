{
  description = "sanstzu's nix";
  
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.2";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix.url = "github:danth/stylix";

    apple-fonts = {
      url = "github:Lyndeno/apple-fonts.nix/master";
    };

  };

  outputs = { nixpkgs, home-manager, ... }@inputs:
    let 
      system = "x86_64-linux";

      mkSystem = pkgs: system: hostname:
        pkgs.lib.nixosSystem {
          system = system;
          modules = [
            { networking.hostName = hostname; }
            ./modules/system/configuration.nix
            ( import (./. + "/hosts/${hostname}") )
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useUserPackages = true;
                useGlobalPkgs = true;
                extraSpecialArgs = { inherit inputs; };
                users.clayt = (./. + "/hosts/${hostname}/user.nix");
              };
            }
          ];

          specialArgs = { inherit inputs; };
       };    
    in {
      nixosConfigurations =  {
        asus-rog = mkSystem inputs.nixpkgs "x86_64-linux" "asus-rog";
      };
    };
  
}
