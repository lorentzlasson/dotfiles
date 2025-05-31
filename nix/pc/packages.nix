{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # zed-editor # too slow too compile
    alacritty
    atuin
    bat
    curl
    dbeaver-bin
    deno
    dnsutils
    dos2unix
    dropbox-cli
    eza
    file
    firefox
    gcc
    gleam
    gnumake
    godot_4 # game engine
    gptfdisk
    inxi # system information
    jq
    keymapp # https://blog.zsa.io/keymapp/
    lsof
    lua-language-server
    luajitPackages.luacheck
    nerd-fonts.hack
    nil
    nix-search-cli
    nixpkgs-fmt
    nmap
    nodePackages_latest.bash-language-server
    nodePackages_latest.sql-formatter
    nodePackages_latest.typescript-language-server
    nodejs # for copilot
    obs-studio # Free and open source software for video recording and live streaming.
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
    ripgrep-all
    shellcheck
    speechd # spd-say "hello"
    sqls
    stow
    tcpdump
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
    claude-code
  ];
}
