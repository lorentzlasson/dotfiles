{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    claude-code-overlay.url = "github:ryoppippi/claude-code-overlay";
  };

  outputs =
    { nixpkgs, nixos-hardware, claude-code-overlay, ... }:
    let
      mkSystem =
        hostConfig:
        nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inputs = { inherit nixos-hardware; };
          };
          modules = [
            {
              nixpkgs.overlays = [
                # override the default overlay wrapper which sets telemetry-disabling
                # env vars that also break feature-gated functionality (e.g. remote-control)
                (_final: prev: {
                  claude-code = claude-code-overlay.packages.${prev.stdenv.hostPlatform.system}.claude.overrideAttrs (old: {
                    postFixup = ''
                      wrapProgram $out/bin/claude \
                        --prefix PATH : ${prev.gh}/bin \
                        --set DISABLE_AUTOUPDATER 1 \
                        --set DISABLE_INSTALLATION_CHECKS 1
                    '';
                  });
                })
              ];
            }
            hostConfig
          ];
        };
    in
    {
      nixosConfigurations = {
        xps15 = mkSystem ./xps15/configuration.nix;
        xps13 = mkSystem ./xps13/configuration.nix;
        asus = mkSystem ./asus/configuration.nix;
        nuc = mkSystem ./nuc/configuration.nix;
      };
    };
}
