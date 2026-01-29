{ pkgs, ... }:

{
  imports = [ ./packages.nix ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  users.defaultUserShell = pkgs.zsh;

  virtualisation.docker.enable = true;

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
