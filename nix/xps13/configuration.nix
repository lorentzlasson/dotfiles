{ inputs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      inputs.nixos-hardware.nixosModules.dell-xps-13-9360
      ../pc/configuration.nix
    ];

  networking.hostName = "xps13";
  system.stateVersion = "23.11";
}
