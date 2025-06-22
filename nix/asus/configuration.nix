{ config, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ../pc/configuration.nix
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
      package = config.boot.kernelPackages.nvidiaPackages.beta;
    };
  };

  services = {
    # https://nixos.wiki/wiki/Nvidia
    xserver = {
      videoDrivers = [ "nvidia" ];
    };
    # https://nixos.wiki/wiki/Plex
    plex = {
      enable = true;
      openFirewall = true;
      user = "lorentz";
    };
  };
}
