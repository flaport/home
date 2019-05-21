#!/usr/bin/env bash
#    _____ _     ____  ____  ____  ____  _____ 
#   /    // \   /  _ \/  __\/  _ \/  __\/__ __\
#   |  __\| |   | / \||  \/|| / \||  \/|  / \  
#   | |   | |_/\| |-|||  __/| \_/||    /  | |  
#   \_/   \____/\_/ \|\_/   \____/\_/\_\  \_/  

## Note
#------
# I switched to fish, so this file will not run
# still usefull to have though.


## General settings
#------------------

# disable ctrl-s and ctrl-q
stty -ixon

# infinite history size
HISTSIZE= HISTFILESIZE=

# colored bash prompt.
PS1='\[\033[01;32m\]\w\[\033[00m\]\$  '

# add color to common commands
alias ls='ls -hN --color=auto --group-directories-first'
alias grep="grep --color=auto"

# Python Path (get the pythonpath from ~/.pythonpath)
touch $HOME/.pythonpath
export PYTHONPATH="$(tr '\n' ':' < ~/.pythonpath | head -c -1)"
export PYTHONPATH="${PYTHONPATH//\~/$HOME}"

# Python startup file
touch $HOME/.pythonstartup
export PYTHONSTARTUP="$HOME/.pythonstartup"


## Path
#------

# lumerical fdtd
export PATH="/opt/lumerical/fdtd/bin:$PATH"

# Anaconda python
export PATH="$HOME/.anaconda/bin:$PATH"
if [ -f "$HOME/.anaconda/etc/profile.d/conda.sh" ]; then
    source "$HOME/.anaconda/etc/profile.d/conda.sh" # to enable `conda activate`
fi

# custom scripts
export PATH="$HOME/.scripts:$PATH"

# custom openvpn command
export PATH="$HOME/.config/openvpn:$PATH"

# custom vim command
export PATH="$HOME/.config/nvim/vim:$PATH"

# custom git commands (powered by vim and tmux)
export PATH="$HOME/.config/nvim/git:$PATH"


## Custom commands
#-----------------

# open and disown with default program:
o() { xdg-open "$1" &>/dev/null &disown ;}

