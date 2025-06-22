{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs = { nixpkgs, nixos-hardware, ... }:
    let
      mkSystem = hostConfig: nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inputs = { inherit nixos-hardware; }; };
        modules = [ hostConfig ];
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
