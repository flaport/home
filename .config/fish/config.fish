#!/usr/bin/env fish
#    _____ _     ____  ____  ____  ____  _____
#   /    // \   /  _ \/  __\/  _ \/  __\/__ __\
#   |  __\| |   | / \||  \/|| / \||  \/|  / \
#   | |   | |_/\| |-|||  __/| \_/||    /  | |
#   \_/   \____/\_/ \|\_/   \____/\_/\_\  \_/
#


## Fish greeting
#-------------------------------------------------------------------------------
function fish_greeting # suppress greeting
end


## Vim Mode
#-------------------------------------------------------------------------------
fish_default_key_bindings # enable default mode first to circumvent unmapped "btab" error
fish_vi_key_bindings


## Environment variables
#-------------------------------------------------------------------------------
# some magic to source the variables defined in .bash_profile.
sed -n '/^export/p' $HOME/.bash_profile | sed -e 's/export/set\ -gx/g' | sed -e 's/=/\ /g' | source

## Python
#-------------------------------------------------------------------------------
# create python startup file if it does not exist
touch $HOME/.pythonpath
# create python path file if it does not exist
touch $HOME/.pythonstartup
# set python path from "~/.pythonpath" file
set -gx PYTHONPATH (tr '\n' ':' < $HOME/.pythonpath | head -c -1 | sed -e 's|~|'$HOME'|g')
# enable anaconda python
if test -e "$HOME/.anaconda/etc/fish/conf.d/conda.fish"
    source "$HOME/.anaconda/etc/fish/conf.d/conda.fish"
end


## Keyboard shortcuts
#-------------------------------------------------------------------------------
## accept autosuggestion
bind -M insert \cp accept-autosuggestion
bind \cp accept-autosuggestion
bind -M insert \cn accept-autosuggestion
bind \cn accept-autosuggestion

