{ pkgs, ... }:

{
  imports = [
    ../packages.nix
  ];

  environment.systemPackages = with pkgs; [
    # zed-editor # too slow too compile
    dbeaver-bin
    dropbox-cli
    fd
    firefox
    gh
    gleam
    godot_4 # game engine
    gptfdisk
    keymapp # https://blog.zsa.io/keymapp/
    luajitPackages.luacheck
    nix-search-cli
    nmap
    obs-studio # Free and open source software for video recording and live streaming.
    pavucontrol
    pinta
    protonvpn-gui
    sd
    speechd # spd-say "hello"
    tcpdump
    unison-ucm
    wev

    # unfree
    claude-code
    discord
    gemini-cli
    google-chrome
    signal-desktop
    slack
    spotify
  ];
}
