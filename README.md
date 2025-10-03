# dotfiles
Collection of my personal dotfiles

## Setup
1. `cd ~`
1. `git clone https://github.com/lorentzlasson/dotfiles`
1. `rm ~/.config` # Remove the symlink if it exists
1. `mkdir -p ~/.config` # Create a new, genuine directory
1. `cd dotfiles`
1. `stow .`

## Ref
https://systemcrafters.net/managing-your-dotfiles/using-gnu-stow/

https://www.gnu.org/software/stow/manual/stow.html
