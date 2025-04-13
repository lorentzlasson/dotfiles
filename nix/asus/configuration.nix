{ config, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  networking = {
    hostName = "asus";
    nameservers = [ "127.0.0.1" ];

    firewall = {
      allowedTCPPorts = [ 53 4000 ];
      allowedUDPPorts = [ 53 ];
    };
  };

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

    blocky = {
      enable = true;
      settings = {
        ports = {
          dns = 53; # Port for incoming DNS Queries.
          http = 4000;
        };
        upstreams.groups.default = [
          "https://one.one.one.one/dns-query" # Using Cloudflare's DNS over HTTPS server for resolving queries.
        ];
        # For initially solving DoH/DoT Requests when no system Resolver is available.
        bootstrapDns = {
          upstream = "https://one.one.one.one/dns-query";
          ips = [ "1.1.1.1" "1.0.0.1" ];
        };
        blocking = {
          blackLists = {
            ads = [ "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts" ];
          };
          clientGroupsBlock = {
            default = [ "ads" ];
          };
        };
      };
    };
  };
}
