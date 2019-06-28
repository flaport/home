#!/usr/bin/env bash
#    _____ _     ____  ____  ____  ____  _____
#   /    // \   /  _ \/  __\/  _ \/  __\/__ __\
#   |  __\| |   | / \||  \/|| / \||  \/|  / \
#   | |   | |_/\| |-|||  __/| \_/||    /  | |
#   \_/   \____/\_/ \|\_/   \____/\_/\_\  \_/

## Note
#-------------------------------------------------------------------------------
# if default shell is bash or zsh, this file will be sourced at login
# if default shell is fish, the lines starting with export (environment variables)
#   will be smartly translated into fish environment variables, the rest will be ignored.
#
# current shell: zsh
#

## Path
#-------------------------------------------------------------------------------
# web apps
export PATH="$HOME/.webapps:$PATH"


## Environment variables
#-------------------------------------------------------------------------------
export BROWSER="qutebrowser"
export CC="gcc"
export CXX="g++"
export EDITOR="vim"
export FM="vifm"
export FZF_DEFAULT_OPTS="--layout=reverse --height=60% --multi --bind=ctrl-a:select-all --preview-window=right:wrap --preview='head -$LINES {} | highlight -O ansi --force'"
export FZF_DEFAULT_COMMAND="find . -type f"
export GTK2_RC_FILES="/usr/share/themes/Arc-solid/gtk-2.0/gtkrc"
export ICAROOT="$HOME/.ica"
export PATH="$HOME/.local/bin:$PATH"
export PYTHONSTARTUP="$HOME/.pythonstartup"
export QT_QPA_PLATFORMTHEME="qt5ct"
export READER="zathura"
export SUDO_ASKPASS="$HOME/.config/dmenu/dmenu_askpass"
export TERMINAL="st"
