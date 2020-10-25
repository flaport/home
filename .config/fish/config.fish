#!/usr/bin/env fish
#    _____ _     ____  ____  ____  ____  _____
#   /    // \   /  _ \/  __\/  _ \/  __\/__ __\
#   |  __\| |   | / \||  \/|| / \||  \/|  / \
#   | |   | |_/\| |-|||  __/| \_/||    /  | |
#   \_/   \____/\_/ \|\_/   \____/\_/\_\  \_/
#

## Note
#-------------------------------------------------------------------------------
# I switched to zsh, so this file will not run except when running fish explicitly


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

# some fish magic to source the variables defined in .bash_profile.
sed -n '/^export/p' $HOME/.bash_profile | sed -e 's/export/set\ -gx/g' | sed -e 's/=/\ /g' | source

# colored man pages
set -xU LESS_TERMCAP_md (printf "\e[01;31m")
set -xU LESS_TERMCAP_me (printf "\e[0m")
set -xU LESS_TERMCAP_se (printf "\e[0m")
set -xU LESS_TERMCAP_so (printf "\e[01;44;33m")
set -xU LESS_TERMCAP_ue (printf "\e[0m")
set -xU LESS_TERMCAP_us (printf "\e[01;32m")

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


## Extensions
#-------------------------------------------------------------------------------

# autojump
source "$HOME/.config/autojump/share/autojump/autojump.fish"

