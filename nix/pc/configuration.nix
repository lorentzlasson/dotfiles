{ pkgs, lib, ... }:

{
  imports =
    [
      ../configuration.nix
      ./packages.nix
    ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  time.timeZone = "Europe/Stockholm";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "sv_SE.UTF-8";
      LC_IDENTIFICATION = "sv_SE.UTF-8";
      LC_MEASUREMENT = "sv_SE.UTF-8";
      LC_MONETARY = "sv_SE.UTF-8";
      LC_NAME = "sv_SE.UTF-8";
      LC_NUMERIC = "sv_SE.UTF-8";
      LC_PAPER = "sv_SE.UTF-8";
      LC_TELEPHONE = "sv_SE.UTF-8";
      LC_TIME = "sv_SE.UTF-8";
    };
  };

  users.users.lorentz = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    shell = pkgs.zsh;
  };

  hardware.keyboard.zsa.enable = true;
  security.rtkit.enable = true;

  services = {
    xserver = {
      enable = true;
      xkb = {
        layout = "us";
        variant = "altgr-intl";
      };
    };

    desktopManager.gnome.enable = true;
    displayManager.gdm.enable = true;

    printing.enable = true;

    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
    };

    fprintd = {
      enable = true;
      package = pkgs.fprintd-tod;
      tod = {
        enable = true;
        driver = pkgs.libfprint-2-tod1-goodix;
      };
    };

    openvpn.servers = {
      mp = {
        config = ''
          config /etc/nixos/vpn/mp.ovpn
        '';
        autoStart = false;
        updateResolvConf = true;
      };
    };
  };

  console.useXkbConfig = true;


  programs = {
    _1password.enable = true;
    captive-browser = {
      enable = true;
      interface = "wlp58s0";
    };
    git.enable = true;
    neovim = {
      enable = true;
      defaultEditor = true;
    };
    steam.enable = true;
    tmux = {
      enable = true;
      plugins = with pkgs.tmuxPlugins; [
        sensible
        resurrect
      ];
    };
    direnv.enable = true;

    zsh = {
      enable = true;
      syntaxHighlighting.enable = true;
    };

  };

  # GNOME settings via systemd user service
  systemd.user.services.gnome-settings = {
    description = "Apply GNOME settings";
    wantedBy = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    path = [ pkgs.glib ];
    script = "${pkgs.bash}/bin/bash ${./gnome-settings.sh}";
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
  };

  # https://nixos.wiki/wiki/Dropbox
  networking = {
    # hostName handled by machine specific config
    networkmanager = {
      enable = true;
      settings.connectivity.enabled = true;
    };

    firewall = {
      allowedTCPPorts = [ 17500 ];
      allowedUDPPorts = [ 17500 ];

      extraCommands = ''
        # allow docker to access host network
        iptables -I nixos-fw 1 -i docker0 -s 172.16.0.0/12 -j ACCEPT
        iptables -I nixos-fw 1 -i br+     -s 172.16.0.0/12 -j ACCEPT
      '';
    };
  };

  systemd.user.services.dropbox = {
    wantedBy = [ "graphical-session.target" ];
    environment = {
      QT_PLUGIN_PATH = "/run/current-system/sw/" + pkgs.qt5.qtbase.qtPluginPrefix;
      QML2_IMPORT_PATH = "/run/current-system/sw/" + pkgs.qt5.qtbase.qtQmlPrefix;
    };
    serviceConfig = {
      ExecStart = "${lib.getBin pkgs.dropbox}/bin/dropbox";
      ExecReload = "${lib.getBin pkgs.coreutils}/bin/kill -HUP $MAINPID";
      KillMode = "control-group"; # upstream recommends process
      Restart = "on-failure";
      PrivateTmp = true;
      ProtectSystem = "full";
      Nice = 10;
    };
  };

  nixpkgs.config.allowUnfree = true;
}
