#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

export EDITOR="vim"
export TERMINAL="st"
export BROWSER="qutebrowser"
export TRUEBROWSER="qutebrowser"
export READER="zathura"

# Start graphical server if i3 not already running.
if [ "$(tty)" = "/dev/tty1" ]; then
	pgrep -x i3 || exec startx
fi

