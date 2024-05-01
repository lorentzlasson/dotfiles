{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { nixpkgs, ... }: {
    nixosConfigurations.xps15 = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./xps15/hardware-configuration.nix
        ./xps15/configuration.nix
        ./configuration.nix
      ];
    };

    nixosConfigurations.asus = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./asus/hardware-configuration.nix
        ./asus/configuration.nix
        ./configuration.nix
      ];
    };
  };
}
