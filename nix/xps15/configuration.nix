{ inputs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      inputs.nixos-hardware.nixosModules.dell-xps-15-9520
    ];

  networking.hostName = "xps15";
}
