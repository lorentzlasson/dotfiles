### delete old generations
1. `sudo nix-env --list-generations --profile /nix/var/nix/profiles/system` - list generations 
1. `sudo nix-env --delete-generations +3 --profile /nix/var/nix/profiles/system` - delete all but 3 latest
1. `sudo nixos-rebuild boot --flake ~/dotfiles/nix` - free up boot partition

### collect garbage
- `sudo nix-collect-garbage`

### install on new computer
1. get iso `https://nixos.org/manual/nixos/stable/#sec-obtaining`
1. write to usb `sudo dd if=<PATH_TO_ISO> of=<PATH_TO_DEVICE(/dev/sdXyn> bs=4M status=progress conv=fsync`
