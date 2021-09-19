# enable colors and change prompt
autoload -U colors && colors
PS1="%B%F{32}%*%f %b%~ $ "

# history in cache directory
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt EXTENDED_HISTORY

# basic auto/tab complete
autoload -U compinit
zstyle ':completion:*' menu select
  zmodload zsh/complist
  compinit
  _comp_options+=(globdots) # include hidden files.

# globbing
setopt extended_glob

# allow # to comment
set -k

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
bindkey "^P" up-line-or-search
bindkey "^N" down-line-or-search

# custom aliases
source ~/.sh_aliases

# custom functions
source ~/.sh_functions

# fuzzy history search
source ~/.fzf.zsh

# set vim as default editor
export VISUAL=nvim.appimage
export EDITOR="$VISUAL"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# --- PATH
export PATH="/home/lorentz/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

export PATH=~/.local/bin:$PATH
# add current node bin to path
# export PATH=$PATH:node_modules/.bin

export DENO_INSTALL="/home/lorentz/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"


# cd on steroids
# https://github.com/ajeetdsouza/zoxide

eval "$(zoxide init zsh)"

# Direnv hook https://direnv.net/docs/hook.html#zsh
eval "$(direnv hook zsh)"

# load zsh-syntax-highlighting; should be last
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null

# if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
#   exec tmux
# fi
