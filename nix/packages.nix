{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    alacritty
    astro-language-server
    atuin
    bat
    cloudflared
    curl
    delta
    deno
    dnsutils
    dos2unix
    eza
    file
    gcc
    gnumake
    htop
    inxi # system information
    jq
    lsof
    lua-language-server
    nerd-fonts.hack
    nil
    nix-index
    nixpkgs-fmt
    nodePackages_latest.bash-language-server
    nodePackages_latest.sql-formatter
    nodePackages_latest.typescript-language-server
    pciutils # system information
    pgcli
    postgres-language-server
    pspg
    python3
    ripgrep
    ripgrep-all
    shellcheck
    sqls
    terraform-ls
    tree
    usbutils # lsbusb
    vscode-langservers-extracted
    wget
    xclip
    yaml-language-server
    zoxide
  ];
}
