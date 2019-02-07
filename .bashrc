## General settings
#------------------

# disable ctrl-s and ctrl-q
stty -ixon

# cd into directory without typing cd
shopt -s autocd

# infinite history size
HISTSIZE= HISTFILESIZE=

# colored bash prompt.
if [ "$EUID" -ne 0 ]
	then export PS1="\[$(tput bold)\]\[$(tput setaf 1)\][\[$(tput setaf 3)\]\u\[$(tput setaf 2)\]@\[$(tput setaf 4)\]\h \[$(tput setaf 5)\]\W\[$(tput setaf 1)\]]\[$(tput setaf 7)\]\\$ \[$(tput sgr0)\]"
	else export PS1="\[$(tput bold)\]\[$(tput setaf 1)\][\[$(tput setaf 3)\]ROOT\[$(tput setaf 2)\]@\[$(tput setaf 4)\]$(hostname | awk '{print toupper($0)}') \[$(tput setaf 5)\]\W\[$(tput setaf 1)\]]\[$(tput setaf 7)\]\\$ \[$(tput sgr0)\]"
fi

# add color to common commands
alias ls='ls -hN --color=auto --group-directories-first'
alias grep="grep --color=auto"
alias ccat="highlight --out-format=ansi"

# fuzzy file finder (fzf command)
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Python Path (get the pythonpath from ~/.pythonpath)
export PYTHONPATH="$(tr '\n' ':' < ~/.pythonpath | head -c -1)"
export PYTHONPATH="${PYTHONPATH//\~/$HOME}"

## Path
#------

# lumerical fdtd
export PATH="/opt/lumerical/fdtd/bin:$PATH"

# Anaconda python
export PATH="$HOME/.anaconda/bin:$PATH"

# custom scripts
export PATH="$HOME/.scripts:$PATH"

# custom vim command
export PATH="$HOME/.config/nvim/vim:$PATH"

# custom git commands (powered by vim and tmux)
export PATH="$HOME/.config/nvim/git:$PATH"


## Aliases
#---------

# ranger aliases (exit ranger in directory last visited)
alias r='ranger --choosedir=$HOME/.rangerdir; LASTDIR=`cat $HOME/.rangerdir`; cd "$LASTDIR"'
alias ranger='ranger --choosedir=$HOME/.rangerdir; LASTDIR=`cat $HOME/.rangerdir`; cd "$LASTDIR"'

# logout
alias logout='i3-msg exit'

# internet
alias ytd="youtube-dl --add-metadata -ic" # Download video link
alias yta="yt -x -f bestaudio/best" # Download only audio
alias yt="youtube-viewer"
alias ethspeed="speedometer -r enp0s25"
alias wifispeed="speedometer -r wlp3s0"
alias starwars="telnet towel.blinkenlights.nl"

## Custom commands
#-----------------

# open and disown with default program:
o() { xdg-open "$1" &>/dev/null &disown ;}

