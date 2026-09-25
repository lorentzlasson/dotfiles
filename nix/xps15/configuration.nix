{ inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    inputs.nixos-hardware.nixosModules.dell-xps-15-9520
    ../pc/configuration.nix
    ../pc/nvidia.nix
    ../pc/steam.nix
  ];

  networking.hostName = "xps15";
  system.stateVersion = "23.11";

  boot = {
    blacklistedKernelModules = [ "spd5118" ];
    kernelParams = [ "usbcore.autosuspend=-1" ];
  };

  hardware.nvidia = {
    powerManagement.finegrained = false;
    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };
}
