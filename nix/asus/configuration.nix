{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../pc/configuration.nix
  ];

  networking.hostName = "asus";
  system.stateVersion = "23.11";

  # XBOOTLDR setup for dual boot with small Windows ESP
  boot.loader = {
    efi.efiSysMountPoint = "/efi";
    systemd-boot.xbootldrMountPoint = "/boot";
  };

  environment.sessionVariables = {
    __NV_PRIME_RENDER_OFFLOAD = "1";
    __NV_PRIME_RENDER_OFFLOAD_PROVIDER = "NVIDIA-G0";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    __VK_LAYER_NV_optimus = "NVIDIA_only";
  };

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
    # library in /srv/plex
    plex = {
      enable = true;
      openFirewall = true;
      user = "lorentz";
    };
  };

  systemd.tmpfiles.rules = [
    "d /srv/plex 0755 lorentz users -"
  ];
}
