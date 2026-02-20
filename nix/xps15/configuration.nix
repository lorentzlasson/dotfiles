{ config, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    inputs.nixos-hardware.nixosModules.dell-xps-15-9520
    ../pc/configuration.nix
  ];

  networking.hostName = "xps15";
  system.stateVersion = "23.11";

  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  boot = {
    blacklistedKernelModules = [ "spd5118" ];
    kernelParams = [ "usbcore.autosuspend=-1" ];
  };

  hardware = {
    graphics.enable = true;
    nvidia = {
      modesetting.enable = true;
      powerManagement = {
        enable = true;
        finegrained = true;
      };
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.beta;
      prime = {
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
      };
    };
  };

  services.xserver.videoDrivers = [ "nvidia" ];
}
