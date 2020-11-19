#!/usr/bin/env bash
#    _____ _     ____  ____  ____  ____  _____
#   /    // \   /  _ \/  __\/  _ \/  __\/__ __\
#   |  __\| |   | / \||  \/|| / \||  \/|  / \
#   | |   | |_/\| |-|||  __/| \_/||    /  | |
#   \_/   \____/\_/ \|\_/   \____/\_/\_\  \_/

## Note
#-------------------------------------------------------------------------------
# I switched to zsh, so this file will not run except when running bash explicitly

## General settings
#-------------------------------------------------------------------------------

# source function (ignore file if file does not exist)
function sourcefile {
    [[ -f "$1" ]] && source "$1"
}

# source settings not in source control
sourcefile $HOME/.bashrc2

# disable ctrl-s and ctrl-q
stty -ixon

# colored bash prompt.
prompt_command() {
    PS1='\[\033[01;32m\]\w\[\033[00m\]\$  '
}
PROMPT_COMMAND=prompt_command


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
alias pip="pip --no-cache-dir"
man() { # colored man pages:
    LESS_TERMCAP_md=$'\e[01;31m' \
        LESS_TERMCAP_me=$'\e[0m' \
        LESS_TERMCAP_se=$'\e[0m' \
        LESS_TERMCAP_so=$'\e[01;44;33m' \
        LESS_TERMCAP_ue=$'\e[0m' \
        LESS_TERMCAP_us=$'\e[01;32m' \
        command man "$@"
    }


## Extensions
#-------------------------------------------------------------------------------

# conda (scientific python distribution and environments)
sourcefile "$HOME/.anaconda/etc/profile.d/conda.sh"

# travis (continuous integration)
sourcefile "$HOME/.travis/travis.sh"

# broot (fuzzy file finder/jumper/...)
sourcefile $HOME/.config/broot/launcher/bash/br

# autojump
sourcefile $HOME/.config/autojump/share/autojump/autojump.bash

# my custom autojump commands (slightly different from default behavior):
sourcefile $HOME/.scripts/autojump/autojump-improved.zsh

# stderr in red:
[ -f $HOME/.config/stderred/build/libstderred.so ] && export LD_PRELOAD="$HOME/.config/stderred/build/libstderred.so${LD_PRELOAD:+:$LD_PRELOAD}"
