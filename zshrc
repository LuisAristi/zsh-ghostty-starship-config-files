# ============================================================
# ZSH
# PowerShell-like interactive editing
# ============================================================

# ------------------------------------------------------------
# Emacs-style editing
# ------------------------------------------------------------

bindkey -e


# ------------------------------------------------------------
# History
# ------------------------------------------------------------

HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000

setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt SHARE_HISTORY


# ------------------------------------------------------------
# Word style
# ------------------------------------------------------------

# Make word movement behave more like Bash/PowerShell:
# words are primarily alphanumeric sequences.

autoload -U select-word-style
select-word-style bash


# ============================================================
# NORMAL WORD MOVEMENT
# ============================================================

# Ctrl + Left
power-left() {
    REGION_ACTIVE=0
    zle backward-word
}

# Ctrl + Right
power-right() {
    REGION_ACTIVE=0
    zle forward-word
}

zle -N power-left
zle -N power-right


# ============================================================
# WORD SELECTION
# ============================================================

# Ctrl + Shift + Left
power-select-left() {
    if (( ! REGION_ACTIVE )); then
        zle set-mark-command
    fi

    zle backward-word
    REGION_ACTIVE=1
}

# Ctrl + Shift + Right
power-select-right() {
    if (( ! REGION_ACTIVE )); then
        zle set-mark-command
    fi

    zle forward-word
    REGION_ACTIVE=1
}

zle -N power-select-left
zle -N power-select-right


# ============================================================
# DELETE WORD
# ============================================================

# Ctrl + Backspace
power-backspace() {
    if (( REGION_ACTIVE )); then
        zle kill-region
    else
        zle backward-kill-word
    fi
}

# Ctrl + Delete
power-delete() {
    if (( REGION_ACTIVE )); then
        zle kill-region
    else
        zle kill-word
    fi
}

zle -N power-backspace
zle -N power-delete


# ============================================================
# KEY BINDINGS
# ============================================================

# Normal word movement
bindkey $'\e[1;5D' power-left
bindkey $'\e[1;5C' power-right

# Word selection
bindkey $'\e[1;6D' power-select-left
bindkey $'\e[1;6C' power-select-right

# Delete words
bindkey $'\e[99~' power-backspace
bindkey $'\e[98~' power-delete


# ============================================================
# STANDARD POWER-SHELL-LIKE SHORTCUTS
# ============================================================

# Home / End
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line

# Ctrl + W
bindkey '^W' backward-kill-word

# Ctrl + U
bindkey '^U' backward-kill-line

# Ctrl + K
bindkey '^K' kill-line

# Ctrl + Y
bindkey '^Y' yank

# ============================================================
# HISTORY SEARCH
# ============================================================

# Up / Down search through history matching current input
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search

zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

bindkey '^[[A' up-line-or-beginning-search
bindkey '^[[B' down-line-or-beginning-search

# Copy current ZLE selection to Wayland clipboard
copy-region-to-clipboard() {
    if (( REGION_ACTIVE )); then
        local start=$MARK
        local end=$CURSOR

        if (( start > end )); then
            local tmp=$start
            start=$end
            end=$tmp
        fi

        local text="${BUFFER[start+1,end]}"

        print -rn -- "$text" | wl-copy

        zle deactivate-region
    fi
}

zle -N copy-region-to-clipboard
# Ctrl+Shift+C
bindkey '^[[100~' copy-region-to-clipboard

bindkey '^[[1;6D' power-select-left
bindkey '^[[1;6C' power-select-right

# ===================
# starship init
# ==================

eval "$(starship init zsh)"

# The following lines were added by compinstall

zstyle ':completion:*' completer _complete _ignored _approximate
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]} r:|[.]=** r:|=**'
zstyle :compinstall filename '/home/lll/.zshrc'

autoload -Uz compinit
compinit

zstyle ':completion:*' menu select
bindkey '^[[Z' reverse-menu-complete
# End of lines added by compinstall
