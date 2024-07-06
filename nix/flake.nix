{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { nixpkgs, ... }: {
    nixosConfigurations.xps15 = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./xps15/configuration.nix
        ./configuration.nix
      ];
    };

    nixosConfigurations.xps13 = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./xps13/configuration.nix
        ./configuration.nix
      ];
    };

    nixosConfigurations.asus = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./asus/configuration.nix
        ./configuration.nix
      ];
    };
  };
}
