{ inputs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      inputs.nixos-hardware.nixosModules.dell-xps-13-9360
    ];

  networking.hostName = "xps13";
}
