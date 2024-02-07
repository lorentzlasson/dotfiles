# enable colors and change prompt
autoload -Uz colors && colors
PS1="%B%F{32}%*%f %b%~ $ "
# PS1="%B%F{32}%*%f%b ${PWD/*\//} $ " # do something about deep paths

# history in cache directory
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt EXTENDED_HISTORY

# basic auto/tab complete
autoload -Uz compinit
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
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^e' edit-command-line

# search history with ctrl-r
bindkey -v
bindkey '^R' history-incremental-search-backward
bindkey "^P" up-line-or-search
bindkey "^N" down-line-or-search

# Yank to the system clipboard
function vi-yank-xclip {
  zle vi-yank
  echo "$CUTBUFFER" | xclip -sel clip
}

zle -N vi-yank-xclip
bindkey -M vicmd 'y' vi-yank-xclip

# custom aliases
source ~/.sh_aliases

# custom functions
source ~/.sh_functions

# fuzzy history search
source ~/.fzf.zsh

# set vim as default editor
export VISUAL=nvim
export EDITOR="$VISUAL"

export PATH=~/.local/bin:$PATH

export PATH=~/.npm-global/bin:$PATH
# add current node bin to path
export PATH=$PATH:node_modules/.bin

export DENO_INSTALL="/home/lorentz/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

# go
export PATH="/usr/local/go/bin:$PATH"

# cd on steroids https://github.com/ajeetdsouza/zoxide
if command -v zoxide &> /dev/null; then
  eval "$(zoxide init zsh)"
fi

# Direnv hook https://direnv.net/docs/hook.html#zsh
if command -v direnv &> /dev/null; then
  eval "$(direnv hook zsh)"
fi

# kubectl
if command -v kubectl &> /dev/null; then
  source <(kubectl completion zsh)
fi

# load zsh-syntax-highlighting; should be last
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/lorentz/google-cloud-sdk-368.0.0-linux-x86_64/google-cloud-sdk/path.zsh.inc' ]; then . '/home/lorentz/google-cloud-sdk-368.0.0-linux-x86_64/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/lorentz/google-cloud-sdk-368.0.0-linux-x86_64/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/lorentz/google-cloud-sdk-368.0.0-linux-x86_64/google-cloud-sdk/completion.zsh.inc'; fi
