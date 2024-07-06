{ pkgs, lib, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  networking.hostName = "xps13";
}
