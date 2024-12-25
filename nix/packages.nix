{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    alacritty
    bat
    curl
    dbeaver-bin
    deno
    dropbox-cli
    eza
    file
    gcc
    gleam
    gptfdisk
    graphite-cli
    jq
    keymapp # https://blog.zsa.io/keymapp/
    lsof
    lua-language-server
    mattermost-desktop
    nerdfonts
    nil
    nixpkgs-fmt
    nodejs # for copilot
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
    zoxide

    # unfree
    discord
    google-chrome
    signal-desktop
    slack
    spotify
  ];
}
