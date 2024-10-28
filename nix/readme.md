### delete old generations
- `sudo nix-env --list-generations --profile /nix/var/nix/profiles/system` - list generations 
- `sudo nix-env --delete-generations +3 --profile /nix/var/nix/profiles/system` - delete all but 3 latest
- `sudo nix-collect-garbage` - free up boot partition
