{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { nixpkgs, ... }:
    let
      mkSystem = hostConfig: baseConfig: nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          hostConfig
          baseConfig
        ];
      };
    in
    {
      nixosConfigurations = {
        xps15 = mkSystem ./xps15/configuration.nix ./pc/configuration.nix;
        xps13 = mkSystem ./xps13/configuration.nix ./pc/configuration.nix;
        asus = mkSystem ./asus/configuration.nix ./pc/configuration.nix;
        nuc = mkSystem ./nuc/configuration.nix ./server/configuration.nix;
      };
    };
}
