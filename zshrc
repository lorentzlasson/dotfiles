# enable colors and change prompt
autoload -U colors && colors
PS1="%B%F{32}%*%f %b%~ $ "

# history in cache directory
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history

# basic auto/tab complete
autoload -U compinit
zstyle ':completion:*' menu select
  zmodload zsh/complist
  compinit
  _comp_options+=(globdots) # include hidden files.

# vi mode
bindkey -v
export KEYTIMEOUT=1

# use vim keys in tab complete menu
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# search history with ctrl-r
bindkey -v
bindkey '^R' history-incremental-search-backward

# custom aliases
source ~/.sh_aliases

# custom functions
source ~/.sh_functions

# fuzzy history search
source ~/.fzf.zsh

# add current node bin to path
export PATH=$PATH:node_modules/.bin

# set vim as default editor
export VISUAL=nvim
export EDITOR="$VISUAL"

# load zsh-syntax-highlighting; should be last
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
