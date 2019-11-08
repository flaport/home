#!/usr/bin/env bash
#    _____ _     ____  ____  ____  ____  _____
#   /    // \   /  _ \/  __\/  _ \/  __\/__ __\
#   |  __\| |   | / \||  \/|| / \||  \/|  / \
#   | |   | |_/\| |-|||  __/| \_/||    /  | |
#   \_/   \____/\_/ \|\_/   \____/\_/\_\  \_/

## Note
#-------------------------------------------------------------------------------
#
# if default shell is bash or zsh, this file will be sourced at login.
#
# if default shell is fish, this file will be parsed in such a way that the
# lines starting with export - the environment variables - will be translated
# into fish environment variables. The rest of the file will then be ignored.
#
# current shell: zsh
#

## Anaconda python
#-------------------------------------------------------------------------------
CONDA_INIT="$( $HOME/.anaconda/bin/conda shell.bash hook 2> /dev/null)"
[ $? = 0 ] && eval "$CONDA_INIT"

## Environment variables
#-------------------------------------------------------------------------------
export BROWSER="firefox"
export CC="gcc"
export CXX="g++"
export EDITOR="vim"
export FM="vifm"
export FZF_DEFAULT_OPTS="--layout=reverse --height=60% --multi --bind=ctrl-l:preview-down,ctrl-h:preview-up,ctrl-a:select-all --preview-window=right:wrap --preview='fzf_preview {} $LINES'"
export GTK_THEME="Adapta-Nokto-Eta"
export GTK2_RC_FILES="/usr/share/themes/Adapta-Nokto-Eta/gtk-2.0/gtkrc"
export HISTFILE="$HOME/.bash_history"
export HISTSIZE=10000
export HOST=$(hostname)
export ICAROOT="$HOME/.ica"
export PATH="$HOME/.local/bin:$PATH"
export PYTHONSTARTUP="$HOME/.pythonstartup"
export QT_QPA_PLATFORMTHEME="qt5ct"
export READER="zathura"
export SAVEHIST=10000
export SUDO_ASKPASS="$HOME/.local/bin/askpass"
export SUDO_ASKUSERPASS="$HOME/.local/bin/askuserpass"
export TERMINAL="st"

