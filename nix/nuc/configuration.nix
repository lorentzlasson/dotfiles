# Has shitty wifi signal - 2.4GHz performs better than 5GHz
{
  imports =
    [
      ./hardware-configuration.nix
    ];

  networking.hostName = "nuc";

  fileSystems."/mnt/data" = {
    device = "/dev/disk/by-uuid/3262d20e-55a6-4cde-b059-ae51a6665ebe";
    fsType = "ext4";
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
          denylists = {
            ads = [ "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts" ];
          };
          clientGroupsBlock = {
            default = [ "ads" ];
          };
        };

        prometheus = {
          enable = true;
          path = "/metrics";
        };
      };
    };

    prometheus = {
      enable = true;
      port = 9090;

      scrapeConfigs = [
        {
          job_name = "blocky";
          static_configs = [
            {
              targets = [ "localhost:4000" ];
              labels = {
                instance = "blocky";
              };
            }
          ];
          metrics_path = "/metrics";
        }
      ];
    };

    grafana = {
      enable = true;
      settings = {
        server = {
          http_port = 3000;
          http_addr = "0.0.0.0";
        };
      };

      # Provision the Prometheus data source automatically
      provision = {
        datasources.settings.datasources = [
          {
            name = "Prometheus";
            type = "prometheus";
            access = "proxy";
            url = "http://localhost:9090";
          }
        ];
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
        3000
        4000
        53
        9090
      ];
      allowedUDPPorts = [ 53 ];
    };
    interfaces.wlp1s0.useDHCP = true;
  };
}
