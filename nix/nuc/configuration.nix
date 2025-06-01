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

  security.acme = {
    acceptTerms = true;
    defaults.email = "<EMAIL>";
  };

  services = {
    openssh.enable = true;

    nginx = {
      enable = true;
      virtualHosts = {
        "grafana.lorentz.casa" = {
          enableACME = true;
          forceSSL = true;
          locations."/" = {
            proxyPass = "http://localhost:3000";
            extraConfig = ''
              proxy_set_header Host $host;
              proxy_set_header X-Real-IP $remote_addr;
              proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
              proxy_set_header X-Forwarded-Proto $scheme;
            '';
          };
        };
        "_" = {
          default = true;
          locations."/" = {
            return = "404";
          };
        };
      };
    };

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

      exporters = {
        node = {
          enable = true;
          enabledCollectors = [
            "systemd"
            "cpu"
            "meminfo"
            "diskstats"
            "filesystem"
            "loadavg"
            "netdev"
            "wifi"
          ];
          port = 9100;
        };
      };

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
        {
          job_name = "node";
          static_configs = [
            {
              targets = [ "localhost:9100" ];
              labels = {
                instance = "nuc";
              };
            }
          ];
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

        # admin credentials in password manager

        "auth.anonymous" = {
          enabled = true;
          org_name = "Main Org.";
          org_role = "Viewer";
        };
      };

      # dashboard from
      # https://grafana.com/grafana/dashboards/13768-blocky4/

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
        80
        443
      ];
      allowedUDPPorts = [ 53 ];
    };
    interfaces.wlp1s0.useDHCP = true;
  };
}
