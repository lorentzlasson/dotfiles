{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../pc/configuration.nix
    ../pc/nvidia.nix
    ../pc/steam.nix
  ];

  networking.hostName = "asus";
  system.stateVersion = "23.11";

  nixpkgs.config = {
    cudaCapabilities = [ "8.9" ];
    cudaForwardCompat = false;
  };

  environment = {
    etc."claude-code/managed-settings.json".text = builtins.toJSON {
      remoteControlAtStartup = true;
    };

    systemPackages = [
      (pkgs.callPackage ./bethaniel.nix { nvidiaPackage = config.hardware.nvidia.package; })
    ];

    sessionVariables = {
      __NV_PRIME_RENDER_OFFLOAD = "1";
      __NV_PRIME_RENDER_OFFLOAD_PROVIDER = "NVIDIA-G0";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      __VK_LAYER_NV_optimus = "NVIDIA_only";
    };
  };

  programs.steam = {
    extraPackages = [ pkgs.stdenv.cc.cc.lib ];
    package = pkgs.steam.override {
      extraEnv.LD_PRELOAD = "libgcc_s.so.1";
    };
  };

  boot = {
    blacklistedKernelModules = [ "pwc" ];
    # XBOOTLDR setup for dual boot with small Windows ESP
    loader = {
      efi.efiSysMountPoint = "/efi";
      systemd-boot.xbootldrMountPoint = "/boot";
    };
  };

  # https://nixos.wiki/wiki/Plex
  # library in /srv/plex
  services.plex = {
    enable = true;
    openFirewall = true;
    user = "lorentz";
  };

  systemd.tmpfiles.rules = [
    "d /srv/plex 0755 lorentz users -"
  ];
}
