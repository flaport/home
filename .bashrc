#!/usr/bin/env bash
#    _____ _     ____  ____  ____  ____  _____
#   /    // \   /  _ \/  __\/  _ \/  __\/__ __\
#   |  __\| |   | / \||  \/|| / \||  \/|  / \
#   | |   | |_/\| |-|||  __/| \_/||    /  | |
#   \_/   \____/\_/ \|\_/   \____/\_/\_\  \_/

## Note
#-------------------------------------------------------------------------------
# I switched to zsh, so this file will not run except when running bash explicitly

# source function (ignore file if file does not exist)
function sourcefile {
    [[ -f $1 ]] && source $1
}


## General settings
#-------------------------------------------------------------------------------

# disable ctrl-s and ctrl-q
stty -ixon

# colored bash prompt.
PS1='\[\033[01;32m\]\w\[\033[00m\]\$  '

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

## Aliases
#-------------------------------------------------------------------------------
alias :q=exit
alias :x=exit
alias :e=$EDITOR
alias grep="grep --color=auto"
alias base="conda activate base"
alias system="conda deactivate && conda deactivate"


## Python
#-------------------------------------------------------------------------------

# enable conda commands but do not activate conda
sourcefile "$HOME/.anaconda/etc/profile.d/conda.sh"


## Extensions
#-------------------------------------------------------------------------------

# autojump
sourcefile /usr/share/autojump/autojump.bash

# stderr in red:
[ -f /usr/lib/libstderred.so ] && export LD_PRELOAD="/usr/lib/libstderred.so${LD_PRELOAD:+:$LD_PRELOAD}"

# broot (fuzzy file finder/jumper/...)
sourcefile $HOME/.config/broot/launcher/bash/br

