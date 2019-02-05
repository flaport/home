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

# Citrix ICA
export ICAROOT="/home/flori/.ica"

# Python Path (get the pythonpath from ~/.pythonpath)
export PYTHONPATH="$(tr '\n' ':' < ~/.pythonpath | head -c -1)"
export PYTHONPATH="${PYTHONPATH//\~/$HOME}"


## Environment
#-------------

# lumerical fdtd
export PATH="/opt/lumerical/fdtd/bin:$PATH"

# git-redate
export PATH="/home/flori/.git-redate:$PATH"

# Anaconda python
export PATH="$HOME/.anaconda/bin:$PATH"
export CC="gcc"
export CXX="g++"

## Aliases
#---------

# ranger aliases (exit ranger in directory last visited)
alias r='ranger --choosedir=$HOME/.rangerdir; LASTDIR=`cat $HOME/.rangerdir`; cd "$LASTDIR"'
alias ranger='ranger --choosedir=$HOME/.rangerdir; LASTDIR=`cat $HOME/.rangerdir`; cd "$LASTDIR"'

# logout alias
alias logout='i3-msg exit'

# chromium: open as app
ca() { chromium --app=http://"$@" &>/dev/null &disown ;}

# chromium apps
alias line="chromium --app=chrome-extension://ophjlpahpchlmihnnnihgmmeilfjmjjc/index.html &>/dev/null &disown"
alias whatsapp="chromium --app=http://web.whatsapp.com &>/dev/null &disown"
alias messenger="chromium --app=http://messenger.com &>/dev/null &disown"
alias youtube="ca youtube.com"
alias photos="ca photos.google.com"
alias docs="ca docs.google.com"
alias sheets="ca sheets.google.com"
alias slides="ca slides.google.com"
alias drive="ca drive.google.com"
alias lab="ca localhost:8000"
alias facebook="ca facebook.com"
alias gmail="ca gmail.com"
alias gmail0="ca mail.google.com/mail/u/0/"
alias gmail1="ca mail.google.com/mail/u/1/"
alias gmail2="ca mail.google.com/mail/u/2/"
alias maps="ca maps.google.com"
alias overleaf="ca overleaf.com"
alias calendar="ca calendar.google.com"

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

# openvpn (opens in a tmux session)
openvpn() {
    ~/.config/openvpn/openvpn
}

# lumerical fdtd
fdtd() {
    /opt/lumerical/fdtd/bin/fdtd-solutions $1 &>/dev/null &disown ;
}

# klayout
klayout() { /usr/bin/klayout -e "$@" &>/dev/null &disown ;}

# change matplotlib style globally
# NOTE: for this to work, you need to have matplotlib
# stylesheets in ~/.config/matplotlib/stylelib/
mpl(){
if [[ "$1" =~ "list" ]]; then
    CWD=$PWD;
    cd ~/.config/matplotlib/stylelib ;
    ls *.mplstyle | sed -e 's/\..*$//';
    cd $CWD;
else
    cp ~/.config/matplotlib/stylelib/"$1".mplstyle ~/.config/matplotlib/matplotlibrc ;
fi
}

# clean git history
git-clean-history(){ echo git filter-branch --force --index-filter \'git rm -rf --cached --ignore-unmatch $1\' --prune-empty --tag-name-filter cat -- --all ;}

