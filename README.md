# dotfiles
Collection of my personal dotfiles

## Setup
- `cd ~`
- `git clone https://github.com/lorentzlasson/dotfiles`
- `rm ~/.config` # Remove the symlink if it exists
- `mkdir -p ~/.config` # Create a new, genuine directory
- `cd dotfiles`
- `stow .`
- `ls -lah ~/.config` # TODO: remove this verification step if it behaves as expected next time

## Ref
https://systemcrafters.net/managing-your-dotfiles/using-gnu-stow/

https://www.gnu.org/software/stow/manual/stow.html
