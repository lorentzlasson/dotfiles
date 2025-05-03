{ config, lib, pkgs, ... }:

{
  imports = [ ./packages.nix ];

  system.stateVersion = "24.11";

  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
  };

  services.openssh.enable = true;

  networking = {
    networkmanager.enable = true;
    firewall.allowedTCPPorts = [ 22 ];
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
