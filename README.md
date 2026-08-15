# dotfiles
Collection of my personal dotfiles

## Setup
1. `cd ~`
1. `git clone https://github.com/lorentzlasson/dotfiles`
1. `cd dotfiles`
1. `rm ~/.config` 
1. `rm -rf ~/.config && mkdir -p ~/.config && just stow` 

## Prompt segments
A project can render its own marker on the right hand side of the prompt by exporting `PROMPT_SEGMENT_SOURCE` (e.g. from `.envrc` or a devshell `shellHook`).

It points at a shell file defining a `prompt_segment` function that prints the marker. The file is sourced once per path, then the function is called every prompt. Output is used as `RPROMPT`, so zsh prompt escapes like `%F{green}` work.

Unset the variable (or leave the directory) and the marker disappears. Missing files, missing functions and failing renderers render nothing.

## Ref
https://systemcrafters.net/managing-your-dotfiles/using-gnu-stow/

https://www.gnu.org/software/stow/manual/stow.html
