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
# local executables
export PATH="$HOME/.local/bin:$PATH"
# custom vifm script
export PATH="$HOME/.config/vifm/scripts:$PATH"
# custom nvim script
export PATH="$HOME/.config/nvim/nvim:$PATH"
# i3 commands
export PATH="$HOME/.config/i3:$PATH"
# wrapper around st terminal emulator
export PATH="$HOME/.config/st:$PATH"
# wrapper around dmenu (and customized menus!)
export PATH="$HOME/.config/dmenu:$PATH"
# git scripts
export PATH="$HOME/.config/git:$PATH"


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
export SUDO_ASKPASS="$HOME/.config/dmenu/dmenu_askpass"
export GTK2_RC_FILES="/usr/share/themes/Arc-solid/gtk-2.0/gtkrc"
export FZF_DEFAULT_OPTS="--layout=reverse --height=60% --multi --bind=ctrl-a:select-all --preview-window=right:wrap --preview='head -$LINES {} | highlight -O ansi --force'"
export FZF_DEFAULT_COMMAND="find . -type f"
