{ pkgs, ... }:

let
  # AUTO_UPDATE_START - Do not edit manually, use update-claude-code.sh
  claude-code-latest = pkgs.claude-code.overrideAttrs (old: {
    version = "2.0.54";
    src = pkgs.fetchzip {
      url = "https://registry.npmjs.org/@anthropic-ai/claude-code/-/claude-code-2.0.54.tgz";
      hash = "sha256-EVZueeW1MewYmQSHp4flcShqHy5H0S4gET3XtK+ttQA=";
    };
  });
  # AUTO_UPDATE_END
in

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
    imagemagick
    jira-cli-go
    keymapp # https://blog.zsa.io/keymapp/
    luajitPackages.luacheck
    mangohud
    nix-search-cli
    nmap
    obs-studio # Free and open source software for video recording and live streaming.
    pavucontrol
    pinta
    protonvpn-gui
    qbittorrent
    sd
    speechd # spd-say "hello"
    tcpdump
    unison-ucm
    wev
    xournalpp

    # unfree
    claude-code
    discord
    gemini-cli
    (google-chrome.override {
      commandLineArgs = [ "--disable-features=AcceleratedVideoEncoder" ];
    })
    signal-desktop
    slack
    spotify
  ];
}
