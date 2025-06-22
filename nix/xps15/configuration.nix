{ inputs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      inputs.nixos-hardware.nixosModules.dell-xps-15-9520
      ../pc/configuration.nix
    ];

  networking.hostName = "xps15";
  system.stateVersion = "23.11";
}
