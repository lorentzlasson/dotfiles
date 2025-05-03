{ pkgs, ... }:

{
  imports = [ ./packages.nix ];

  system.stateVersion = "24.11";

  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
  };

  services = {
    openssh.enable = true;

    # Point router dns to the ip of this computer
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

  networking = {
    networkmanager = {
      enable = true;
      wifi.powersave = false;
    };
    firewall = {
      allowedTCPPorts = [
        22
        53
        4000
      ];
      allowedUDPPorts = [ 53 ];
    };
    interfaces.wlp1s0.useDHCP = true;
  };

  users.defaultUserShell = pkgs.zsh;

  programs = {
    git.enable = true;
    neovim = {
      enable = true;
      defaultEditor = true;
    };
    direnv.enable = true;
    zsh = {
      enable = true;
      syntaxHighlighting.enable = true;
    };
  };
}
