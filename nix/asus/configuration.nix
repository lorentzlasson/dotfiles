{ config, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  networking.hostName = "asus";

  # https://nixos.wiki/wiki/Nvidia
  hardware = {
    graphics.enable = true;
    nvidia = {
      modesetting.enable = true;
      powerManagement.enable = false;
      powerManagement.finegrained = false;
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
  };

  services.xserver.videoDrivers = [ "nvidia" ];
}
