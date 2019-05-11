#!/usr/bin/env bash

#
# ~/.bash_profile
#

# Source .bashrc
[[ -f ~/.bashrc ]] && source ~/.bashrc

# Environment variables
export CC="gcc"
export CXX="g++"
export EDITOR="vim"
export TERMINAL="st"
export BROWSER="qutebrowser"
export READER="zathura"
export ICAROOT="$HOME/.ica"
export PATH="$HOME/.scripts:$HOME/.webapps:$PATH"
# export QT_QPA_PLATFORMTHEME="qt5ct"
export GTK2_RC_FILES="/usr/share/themes/Arc-solid/gtk-2.0/gtkrc"

# Start graphical server if i3 not already running.
if [ "$(tty)" = "/dev/tty1" ]; then
	pgrep -x i3 || exec startx
fi

