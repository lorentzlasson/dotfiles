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
            { nixpkgs.overlays = [ claude-code-overlay.overlays.default ]; }
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
