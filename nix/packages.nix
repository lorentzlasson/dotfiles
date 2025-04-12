{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    alacritty
    atuin
    bat
    curl
    dbeaver-bin
    deno
    dropbox-cli
    eza
    file
    gcc
    gleam
    gnumake
    gptfdisk
    graphite-cli
    inxi # system information
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
    obs-studio
    ollama
    pavucontrol
    pciutils # system information
    pgcli
    pinta
    postgres-lsp
    protonvpn-gui
    pspg
    python3
    ripgrep
    shellcheck
    sqls
    stow
    terraform-ls
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
