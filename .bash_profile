#!/usr/bin/env bash

#
# ~/.bash_profile
#

# Source .bashrc
[[ -f ~/.bashrc ]] && source ~/.bashrc

## Environment variables
export CC="gcc"
export CXX="g++"
export FM="vifm"
export EDITOR="vim"
export TERMINAL="st"
export BROWSER="qutebrowser"
export READER="zathura"
export ICAROOT="$HOME/.ica"
export GTK2_RC_FILES="/usr/share/themes/Arc-solid/gtk-2.0/gtkrc"
export SUDO_ASKPASS="/usr/lib/openssh/ssh-askpass-fullscreen"
# export QT_QPA_PLATFORMTHEME="qt5ct"

## Path
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


## Start graphical server if i3 not already running.
if [ "$(tty)" = "/dev/tty1" ]; then
    sleep 3
	pgrep -x i3 || exec startx &> /dev/null
fi

