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
# disable ctrl-s and ctrl-q
stty -ixon
# infinite history size
HISTSIZE= HISTFILESIZE=
# colored bash prompt.
PS1='\[\033[01;32m\]\w\[\033[00m\]\$  '
# add color to common commands
alias ls='ls -hN --color=auto --group-directories-first'
alias grep="grep --color=auto"


## Aliases
#-------------------------------------------------------------------------------
# some vim-like aliases:
alias :q=exit
alias :x=exit
alias :e=$EDITOR


## Python
#-------------------------------------------------------------------------------
# create python startup file if it does not exist
touch $HOME/.pythonpath
# create python path file if it does not exist
touch $HOME/.pythonstartup
# set python path from "~/.pythonpath" file
export PYTHONPATH="$(tr '\n' ':' < ~/.pythonpath | head -c -1 | sed 's|~|'$HOME'|g')"
# enable conda commands
CONDA="$HOME/.anaconda/etc/profile.d/conda.sh" && [ -f $CONDA ] && source $CONDA 
