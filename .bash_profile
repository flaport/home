#!/usr/bin/env bash
#    _____ _     ____  ____  ____  ____  _____
#   /    // \   /  _ \/  __\/  _ \/  __\/__ __\
#   |  __\| |   | / \||  \/|| / \||  \/|  / \
#   | |   | |_/\| |-|||  __/| \_/||    /  | |
#   \_/   \____/\_/ \|\_/   \____/\_/\_\  \_/

## Note
#-------------------------------------------------------------------------------
# I switched to fish, so this file will not run. However, the Path and other
# environment variables defined HERE, WILL be used in the fish initialization.


## Source bashrc
#-------------------------------------------------------------------------------
[[ -f ~/.bashrc ]] && source ~/.bashrc


## Path
#-------------------------------------------------------------------------------
# web apps
export PATH="$HOME/.webapps:$PATH"
# custom scripts
export PATH="$HOME/.scripts:$PATH"
# custom vifm script
export PATH="$HOME/.config/vifm/scripts:$PATH"
# custom nvim script
export PATH="$HOME/.config/nvim/nvim:$PATH"
# i3 commands
export PATH="$HOME/.config/i3:$PATH"
# anaconda python
export PATH="$HOME/.anaconda/bin:$PATH"


## Environment variables
#-------------------------------------------------------------------------------
export CC="gcc"
export CXX="g++"
export FM="vifm"
export EDITOR="vim"
export TERMINAL="st"
export BROWSER="qutebrowser"
export READER="zathura"
export ICAROOT="$HOME/.ica"
export QT_QPA_PLATFORMTHEME="qt5ct"
export PYTHONSTARTUP="$HOME/.pythonstartup"
export SUDO_ASKPASS="/usr/lib/openssh/ssh-askpass-fullscreen"
export GTK2_RC_FILES="/usr/share/themes/Arc-solid/gtk-2.0/gtkrc"


## Start i3
#-------------------------------------------------------------------------------
# [this should be placed last]
if [ "$(tty)" = "/dev/tty1" ]; then
    sleep 3
	pgrep -x i3 || exec startx &> /dev/null
fi

