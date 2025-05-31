{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    alacritty
    atuin
    bat
    curl
    deno
    dnsutils
    dos2unix
    eza
    file
    gcc
    gnumake
    inxi # system information
    jq
    lsof
    lua-language-server
    nerd-fonts.hack
    nil
    nixpkgs-fmt
    nix-index
    nodejs # for copilot
    nodePackages_latest.bash-language-server
    nodePackages_latest.sql-formatter
    nodePackages_latest.typescript-language-server
    pciutils # system information
    pgcli
    postgres-lsp
    pspg
    python3
    ripgrep
    ripgrep-all
    shellcheck
    sqls
    stow
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
