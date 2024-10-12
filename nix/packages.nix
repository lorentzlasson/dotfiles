{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    alacritty
    bat
    curl
    dbeaver-bin
    dropbox-cli
    eza
    file
    gcc
    gleam
    gptfdisk
    graphite-cli
    jq
    lsof
    lua-language-server
    nerdfonts
    nil
    nixpkgs-fmt
    nodePackages_latest.bash-language-server
    nodePackages_latest.sql-formatter
    nodePackages_latest.typescript-language-server
    ollama
    pavucontrol
    pgcli
    pinta
    postgres-lsp
    protonvpn-gui
    pspg
    ripgrep
    shellcheck
    sqls
    stow
    tree
    unison-ucm
    usbutils # lsbusb
    vscode-langservers-extracted
    wev
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
