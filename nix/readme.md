### delete old generations
`./nix/clean_old_gen.sh`

### collect garbage
- `sudo nix-collect-garbage`

### install on new computer
1. get iso `https://nixos.org/manual/nixos/stable/#sec-obtaining`
1. write to usb `sudo dd if=<PATH_TO_ISO> of=<PATH_TO_DEVICE(/dev/sdXyn> bs=4M status=progress conv=fsync`

### update nixos
sudo nix flake update --flake ~/dotfiles/nix
sudo nixos-rebuild switch --flake ~/dotfiles/nix
