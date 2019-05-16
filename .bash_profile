#!/usr/bin/env bash

#
# ~/.bash_profile
#

# Source .bashrc
[[ -f ~/.bashrc ]] && source ~/.bashrc

## Environment variables
export CC="gcc"
export CXX="g++"
export EDITOR="vim"
export TERMINAL="st"
export BROWSER="qutebrowser"
export READER="zathura"
export ICAROOT="$HOME/.ica"
export GTK2_RC_FILES="/usr/share/themes/Arc-solid/gtk-2.0/gtkrc"
# export QT_QPA_PLATFORMTHEME="qt5ct"

## Path
# web apps
export PATH="$HOME/.webapps:$PATH"
# custom scripts
export PATH="$HOME/.scripts:$PATH"
# custom vifm commands
export PATH="$HOME/.config/vifm/scripts:$PATH"
# i3 commands
export PATH="$HOME/.config/i3:$PATH"
# anaconda python
export PATH="$HOME/.anaconda/bin:$PATH"


## Start graphical server if i3 not already running.
if [ "$(tty)" = "/dev/tty1" ]; then
    sleep 3
	pgrep -x i3 || exec startx &> /dev/null
fi

