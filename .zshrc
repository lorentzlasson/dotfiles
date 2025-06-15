# enable colors and change prompt
autoload -Uz colors && colors

PS1="$ "

precmd() {
  # https://en.wikipedia.org/wiki/ANSI_escape_code#Colors
  local blue="\033[0;34m"
  local no_color="\033[0m"
  local current_dir="${PWD##*/}"
  local git_branch=$(git branch --show-current 2>/dev/null)
  local timestamp=$(date +"%H:%M:%S")

  # blue = red in dunkel color scheme
  local base="${blue}${timestamp}${no_color} ${current_dir}"

  local ssh_marker=${SSH_CONNECTION:+ 🔏 $(hostname)}
  local branch_marker=${git_branch:+ 🌿 ${git_branch}}

  echo -e "${base}${ssh_marker}${branch_marker}"
}

silence() {
  unset -f precmd
}

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
setopt GLOBDOTS # include hidden files.

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

clear_and_git_status() {
  clear
  if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    git status
  fi
  precmd
  zle reset-prompt
}
zle -N clear_and_git_status
bindkey '^L' clear_and_git_status

# custom aliases
source ~/.config/shell/aliases.sh

# custom functions
source ~/.config/shell/functions.sh

# set vim as default editor
export VISUAL=nvim
export EDITOR="$VISUAL"

export PATH=~/.local/bin:$PATH

# go
export PATH="/usr/local/go/bin:$PATH"

if command -v tmux &> /dev/null; then
  if [ -z "$TMUX" ]
  then
      tmux attach -t $TMUX || tmux
  fi
fi

# cd on steroids https://github.com/ajeetdsouza/zoxide
if command -v zoxide &> /dev/null; then
  eval "$(zoxide init zsh)"
fi

# Direnv hook https://direnv.net/docs/hook.html#zsh
if command -v direnv &> /dev/null; then
  eval "$(direnv hook zsh)"
fi

# https://docs.atuin.sh/
if command -v atuin &> /dev/null; then
  eval "$(atuin init zsh)"
fi

# kubectl
if command -v kubectl &> /dev/null; then
  source <(kubectl completion zsh)
fi

# ripgrep
if command -v rg &> /dev/null; then
  export RIPGREP_CONFIG_PATH=~/.config/ripgrep/ripgreprc
fi
