# enable colors and change prompt
autoload -U colors && colors
PS1="%B%F{32}%*%f %b%~ $ "
# PS1="%B%F{32}%*%f%b ${PWD/*\//} $ " # do something about deep paths

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

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# place this after nvm initialization!
if command -v nvm &> /dev/null; then
  autoload -U add-zsh-hook
  load-nvmrc() {
    local node_version="$(nvm version)"
    local nvmrc_path="$(nvm_find_nvmrc)"

    if [ -n "$nvmrc_path" ]; then
      local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

      if [ "$nvmrc_node_version" = "N/A" ]; then
        nvm install
      elif [ "$nvmrc_node_version" != "$node_version" ]; then
        nvm use
      fi
    elif [ "$node_version" != "$(nvm version default)" ]; then
      echo "Reverting to nvm default version"
      nvm use default
    fi
  }
  add-zsh-hook chpwd load-nvmrc
  load-nvmrc
fi

# --- PATH
if command -v pyenv &> /dev/null; then
  export PATH="/home/lorentz/.pyenv/bin:$PATH"
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi

export PATH=~/.local/bin:$PATH
# add current node bin to path
# export PATH=$PATH:node_modules/.bin

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