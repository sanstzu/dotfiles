# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  services.udev.extraRules = ''
    ACTION=="add", KERNEL=="asus-nb-wmi", RUN+="${pkgs.bash}/bin/bash -c 'echo 80 > /sys/class/power_supply/BAT?/charge_control_end_threshold'
  '';

  # Time
  time.hardwareClockInLocalTime = true;

  # Install fonts
  fonts = {
        packages = with pkgs; [
            jetbrains-mono
            roboto
            openmoji-color
            nerd-fonts.jetbrains-mono
            font-awesome
            noto-fonts-cjk-sans
        ];

        fontconfig = {
            hinting.autohint = true;
            defaultFonts = {
              emoji = [ "OpenMoji Color" ];
            };
        };
    };

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Programs
  programs = {
    hyprland = {
      enable = true;
      withUWSM = true;
    };

    wireshark.enable = true;

    steam.enable = true;

    zsh.enable = true;
  };


  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Singapore";
  i18n.defaultLocale = "en_SG.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_SG.UTF-8";
    LC_IDENTIFICATION = "en_SG.UTF-8";
    LC_MEASUREMENT = "en_SG.UTF-8";
    LC_MONETARY = "en_SG.UTF-8";
    LC_NAME = "en_SG.UTF-8";
    LC_NUMERIC = "en_SG.UTF-8";
    LC_PAPER = "en_SG.UTF-8";
    LC_TELEPHONE = "en_SG.UTF-8";
    LC_TIME = "en_SG.UTF-8";
  };


  systemd.services.greetd.serviceConfig = {
    Type = "idle";
    StandardInput = "tty";
    StandardOutput = "tty";
    StandardError = "journal"; # Without this errors will spam on screen
    # Without these bootlogs will spam on screen
    TTYReset = true;
    TTYVHangup = true;
    TTYVTDisallocate = true;
  };

  # Security
  security = {
    rtkit.enable = true;
  };

  # Services
  services = {
    
    gvfs.enable  = true;

    udisks2.enable = true;

    blueman.enable = true;

    power-profiles-daemon = {
      enable = true;
    };

    
    # Login screen
    greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --remember --remember-session";
          user = "greeter";
        };
      };
    };

    pipewire = {
      enable = true;

      extraConfig.pipewire = {
        "context.properties" = {
          default.clock.rate = 192000;
          default.clock.allowed-rates = [ 44100 48000 96000 192000 ];
          default.clock.quantum = 32;
          default.clock.min-quantum = 32;
          default.clock.max-quantum = 8192;
        };

        resample.quality = 10;
      };
    };
  };

  # Hardware
  hardware = {
    bluetooth.enable = true;
    graphics.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.clayt = {
    isNormalUser = true;
    description = "Clayton Fernalo";
    extraGroups = [ "networkmanager" "wheel" "wireshark" "docker" ];
    shell = pkgs.zsh;
  };

  # Zsh auto completion
  environment.pathsToLink = [ "/share/zsh" ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim    
    wget
    git
    zsh
    sbctl
    blueman
    greetd.tuigreet

    # hyprland
    xdg-desktop-portal xdg-desktop-portal-hyprland
  ];

  virtualisation.docker.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
