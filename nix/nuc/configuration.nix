# Has shitty wifi signal - 2.4GHz performs better than 5GHz
{
  imports = [
    ./hardware-configuration.nix
    ../configuration.nix
    ./packages.nix
  ] ++ (let
    servicesDir = /etc/nix-services;
  in
    if builtins.pathExists servicesDir then
      map (f: servicesDir + "/${f}") (builtins.attrNames (builtins.readDir servicesDir))
    else
      [ ]
  );

  networking.hostName = "nuc";
  system.stateVersion = "24.11";

  nixpkgs.config.allowUnfree = true;

  systemd.services.blocky = {
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
  };

  fileSystems."/mnt/data" = {
    device = "/dev/disk/by-uuid/3262d20e-55a6-4cde-b059-ae51a6665ebe";
    fsType = "ext4";
  };

  services = {
    openssh.enable = true;

    nginx = {
      enable = true;
      virtualHosts = {
        "grafana.lorentz.casa" = {
          listen = [{ addr = "127.0.0.1"; port = 8083; }];
          locations."/" = {
            proxyPass = "http://localhost:3000";
          };
        };

        "www.lorentz.casa" = {
          listen = [{ addr = "127.0.0.1"; port = 8084; }];
          root = "/var/www";
          locations."/" = {
            tryFiles = "$uri $uri/ =404";
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
          ips = [
            "1.1.1.1"
            "1.0.0.1"
          ];
        };
        # if upstream returns empty result, default cacheTimeNegative (30m) keeps it cached
        # flush via: curl -X POST http://localhost:4000/api/cache/flush
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
          http_addr = "127.0.0.1";
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

    cloudflared = {
      enable = true;
      tunnels.lorentz = {
        credentialsFile = "/etc/cloudflared/lorentz-credentials.json";
        default = "http_status:404";
        ingress = {
          "grafana.lorentz.casa" = "http://localhost:8083";
          "www.lorentz.casa" = "http://localhost:8084";
        };
      };
    };

    # https://nixos.wiki/wiki/Plex
    # library in /srv/plex
    # TODO: create normal user and run plex as that user instead
    plex = {
      enable = true;
      openFirewall = true;
    };
  };

  systemd.tmpfiles.rules = [
    "d /srv/plex 0755 plex plex -"
  ];

  networking = {
    networkmanager = {
      enable = true;
      wifi.powersave = false;
    };
    firewall = {
      allowedTCPPorts = [
        22
        4000
        53
        9090
      ];
      allowedUDPPorts = [ 53 ];
    };
    interfaces.wlp1s0.useDHCP = true;
  };
}
