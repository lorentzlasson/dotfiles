{ pkgs, lib, ... }:

{
  system.stateVersion = "23.11";
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  networking = {
    # hostName handled by machine specific config
    networkmanager.enable = true;
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

  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;

  services = {
    xserver = {
      enable = true;
      xkb = {
        layout = "us";
        variant = "altgr-intl";
      };
      desktopManager.gnome.enable = true;
      displayManager.gdm.enable = true;
    };

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
      tod =  {
        enable = true;
        driver = pkgs.libfprint-2-tod1-goodix;
      };
    };
  };

  console.useXkbConfig = true;

  virtualisation.docker.enable = true;

  programs = {
    _1password.enable = true;
    git.enable = true;
    neovim.enable = true;
    steam.enable = true;
    tmux.enable = true;
    direnv.enable = true;

    zsh = {
      enable = true;
      syntaxHighlighting.enable = true;
    };

    dconf = {
      enable = true;
      profiles.user.databases = [{
        # lockAll = true;
        settings = {
          "org/gnome/desktop/interface".color-scheme = "prefer-dark";

          # disable window tabbing (useless)
          "org/gnome/desktop/wm/keybindings".switch-windows = "[]";
          "org/gnome/desktop/wm/keybindings".switch-windows-backward = "[]";

          # tab between applications on alt tab (grouped by application type, not window)
          "org/gnome/desktop/wm/keybindings".switch-applications = "['<Alt>Tab']";
          "org/gnome/desktop/wm/keybindings".switch-applications-backward = "['<Shift><Alt>Tab']";

          # tab between windows of applications on alt backspace
          "org/gnome/desktop/wm/keybindings".switch-group = "['<Alt>BackSpace']";
          "org/gnome/desktop/wm/keybindings".switch-group-backward = "['<Shift><Alt>BackSpace']";

          # swap caps lock and escape
          "org/gnome/desktop/input-sources".xkb-options = "['caps:swapescape']";

          "org/gnome/settings-daemon/plugins/media-keys" = {
            custom-keybindings = [
              "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
            ];
          };

          "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
            binding = "<Ctrl><Alt>t";
            command = "alacritty";
          };

          "org/gnome/mutter".dynamic-workspaces = false;
          "org/gnome/desktop/wm/preferences".num-workspaces = "1";
        };
      }];
    };
  };

  # https://nixos.wiki/wiki/Dropbox
  networking.firewall = {
    allowedTCPPorts = [ 17500 ];
    allowedUDPPorts = [ 17500 ];
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
  environment.systemPackages = with pkgs; [
    alacritty
    bat
    curl
    dbeaver
    dropbox-cli
    eza
    file
    gptfdisk
    graphite-cli
    jq
    lua-language-server
    nerdfonts
    nil
    nixpkgs-fmt
    nodePackages_latest.bash-language-server
    nodePackages_latest.typescript-language-server
    pspg
    ripgrep
    shellcheck
    stow
    tree
    unison-ucm
    vscode-langservers-extracted
    wget
    xclip
    yaml-language-server
    zed-editor
    zoxide

    # unfree
    discord
    google-chrome
    slack
    signal-desktop
  ];
}
