#
# ~/.bash_profile
#

# Environment variables
export CC="gcc"
export CXX="g++"
export EDITOR="vim"
export TERMINAL="st"
export BROWSER="qutebrowser"
export READER="zathura"
export ICAROOT="/home/flori/.ica"

# Start graphical server if i3 not already running.
if [ "$(tty)" = "/dev/tty1" ]; then
	pgrep -x i3 || exec startx
fi

# Source .bashrc
[[ -f ~/.bashrc ]] && . ~/.bashrc
