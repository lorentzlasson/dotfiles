{ config, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ../pc/configuration.nix
    ];

  networking.hostName = "asus";
  system.stateVersion = "23.11";

  # https://nixos.wiki/wiki/Nvidia
  hardware = {
    graphics.enable = true;
    nvidia = {
      modesetting.enable = true;
      powerManagement.enable = true;
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

    ollama = {
      enable = true;
      acceleration = "cuda";
    };
  };
}
