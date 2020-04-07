#!/usr/bin/zsh
#    _____ _     ____  ____  ____  ____  _____
#   /    // \   /  _ \/  __\/  _ \/  __\/__ __\
#   |  __\| |   | / \||  \/|| / \||  \/|  / \
#   | |   | |_/\| |-|||  __/| \_/||    /  | |
#   \_/   \____/\_/ \|\_/   \____/\_/\_\  \_/


## General settings
#-------------------------------------------------------------------------------

# source function (ignore file if file does not exist)
function sourcefile {
    [[ -f $1 ]] && source $1
}

# enable colors
autoload -U colors && colors

# better tab-completion
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# vi mode
bindkey -v
export KEYTIMEOUT=1

# colored man pages:
man() {
    LESS_TERMCAP_md=$'\e[01;31m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[01;44;33m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[01;32m' \
    command man "$@"
}

# go backward and forward in history (equivalent to up/down arrow)
bindkey "^[h" up-line-or-history # alt + h
bindkey "^[l" down-line-or-history # alt + l
bindkey "^y" "" # noop

# colored zsh prompt
setopt prompt_subst

# zsh theme
sourcefile $HOME/.config/zsh/themes/spaceship.zsh

# change prompt and change cursor shape for different vi modes.
# cursor shape: normal: "█"; insert: "_"
# prompt: normal: ""; insert: ""
NORMAL='\e[1 q\e\\' # █
INSERT='\e[4 q\e\\' # _   - INSERT='\e[5 q\e\\' # |
SPACESHIP_CHAR_SYMBOL_NORMAL=" "
SPACESHIP_CHAR_SYMBOL_INSERT=" "
# in neovim, don't change cursor shape as that doesn't work anyhow :(
[ -z $NVIM_LISTEN_ADDRESS ] || INSERT=$NORMAL
# initialize at startup:
echo -ne $INSERT
SPACESHIP_CHAR_SYMBOL=$SPACESHIP_CHAR_SYMBOL_INSERT
function zle-keymap-select { # gets run every time the mode changes
    if [[ ${KEYMAP} == vicmd ]] || [[ $1 = 'block' ]]; then
        echo -ne $NORMAL
        SPACESHIP_CHAR_SYMBOL=$SPACESHIP_CHAR_SYMBOL_NORMAL
    elif [[ ${KEYMAP} == main ]] || [[ ${KEYMAP} == viins ]] || [[ ${KEYMAP} = '' ]] || [[ $1 = 'beam' ]]; then
        echo -ne $INSERT
        SPACESHIP_CHAR_SYMBOL=$SPACESHIP_CHAR_SYMBOL_INSERT
    fi
    zle reset-prompt
}
function zle-line-init() { # gets run every new line
    echo -ne $INSERT
    SPACESHIP_CHAR_SYMBOL=$SPACESHIP_CHAR_SYMBOL_INSERT
    zle reset-prompt
}
function preexec() { # gets run at new prompt.
    echo -ne $INSERT
    SPACESHIP_CHAR_SYMBOL=$SPACESHIP_CHAR_SYMBOL_INSERT
}
zle -N zle-keymap-select
zle -N zle-line-init

## Aliases
#-------------------------------------------------------------------------------
alias :q=exit
alias :x=exit
alias :e=$EDITOR
alias ll="ls -l"
alias la="ls -la"
alias grep="grep --color=auto"
alias base="conda activate base"
alias system="conda deactivate && conda deactivate"
alias history="history 1"


## Python
#-------------------------------------------------------------------------------

# enable conda commands but do not activate conda
sourcefile "$HOME/.anaconda/etc/profile.d/conda.sh"


## Extensions
#-------------------------------------------------------------------------------

# autojump
sourcefile /usr/share/autojump/autojump.zsh
# my custom autojump commands (slightly different from default behavior):
sourcefile $HOME/.scripts/autojump/autojump-improved.zsh

# broot (fuzzy file finder/jumper/...)
sourcefile $HOME/.config/broot/launcher/bash/br

# zsh autosuggestions (like in the fish shell)
sourcefile /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
bindkey '^p' autosuggest-accept #-execute
bindkey '^n' autosuggest-accept #-execute

# stderr in red:
[ -f /usr/lib/libstderred.so ] && export LD_PRELOAD="/usr/lib/libstderred.so${LD_PRELOAD:+:$LD_PRELOAD}"

# Load zsh-syntax-highlighting; should be last.
sourcefile /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

