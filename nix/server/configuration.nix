{ pkgs, ... }:

{
  imports = [ ./packages.nix ];

  system.stateVersion = "24.11";

  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
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
