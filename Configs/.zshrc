# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in Powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Add in zsh plugins
zinit ice depth=1; zinit light zsh-users/zsh-completions
zinit ice depth=1; zinit light zsh-users/zsh-autosuggestions
zinit ice depth=1; zinit ice wait'1' lucid; zinit light zsh-users/zsh-syntax-highlighting
zinit ice depth=1; zinit ice wait'1' lucid; zinit light Aloxaf/fzf-tab

# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region

# History
HISTSIZE=10000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
setopt append_history
setopt share_history
setopt extended_history
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Dont save wrong commands
zshaddhistory() { whence ${${(z)1}[1]} >| /dev/null || return 1 }

# Remove duplicated commands in zsh_history
function rmdups {
   cat -n "$HISTFILE" | sort -t ';' -uk2 | sort -nk1 | cut -f2- > "$HISTFILE"
}

# Remove commands from history that starts with the given argument e.g. rmcmd foo
function rmcmd {
    local prefix="$1"
    awk -v prefix="$prefix" -F ';' 'index($2, prefix) != 1 { print }' "$HISTFILE" > "$HISTFILE.tmp" && mv "$HISTFILE.tmp" "$HISTFILE"
}

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

# Aliases
alias ls='eza -1 --icons=auto'
#alias ls='ls -p --color=auto'
alias ll='ls -al'
alias c='clear'
alias pacman='sudo pacman'
alias apt='sudo apt'
alias mkdir='mkdir -p'
alias yoink='yay'
alias dl='~/./Shell-scripts/youtube-downloader.py'
alias vim='NVIM_APPNAME=vim nvim'

# Shell integrations
eval "$(fzf --zsh)"
