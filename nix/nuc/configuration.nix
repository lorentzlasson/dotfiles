{
  imports =
    [
      ./hardware-configuration.nix
    ];

  networking.hostName = "nuc";

  fileSystems."/mnt/data" = {
    device = "/dev/disk/by-uuid/3262d20e-55a6-4cde-b059-ae51a6665ebe";
    fsType = "ext4";
  };
}
