# disable ctrl-s and ctrl-q
stty -ixon

# cd into directory without typing cd
shopt -s autocd

# infinite history size
HISTSIZE= HISTFILESIZE=

# set colored bash prompt.
if [ "$EUID" -ne 0 ]
	then export PS1="\[$(tput bold)\]\[$(tput setaf 1)\][\[$(tput setaf 3)\]\u\[$(tput setaf 2)\]@\[$(tput setaf 4)\]\h \[$(tput setaf 5)\]\W\[$(tput setaf 1)\]]\[$(tput setaf 7)\]\\$ \[$(tput sgr0)\]"
	else export PS1="\[$(tput bold)\]\[$(tput setaf 1)\][\[$(tput setaf 3)\]ROOT\[$(tput setaf 2)\]@\[$(tput setaf 4)\]$(hostname | awk '{print toupper($0)}') \[$(tput setaf 5)\]\W\[$(tput setaf 1)\]]\[$(tput setaf 7)\]\\$ \[$(tput sgr0)\]"
fi

# ranger aliases (exit ranger in directory last visited)
alias ranger='ranger --choosedir=$HOME/.rangerdir; LASTDIR=`cat $HOME/.rangerdir`; cd "$LASTDIR"'
alias r='ranger --choosedir=$HOME/.rangerdir; LASTDIR=`cat $HOME/.rangerdir`; cd "$LASTDIR"'
alias dc="rm -rf ~/.cache && echo 'deleted cache'"

# logout alias
alias logout='i3-msg exit'

# openvpn
openvpn() {
    ~/.config/openvpn/openvpn
}

# tmux aliases
alias tmuxa='tmux attach-session -t '

# open and disown with default program:
o() { xdg-open "$1" &>/dev/null &disown ;}

# open a terminal in the same directory
samedir() {
    ID=$(xdpyinfo | grep focus | cut -f4 -d " ")
    PID=$(($(xprop -id $ID | grep -m 1 PID | cut -d " " -f 3) + 2))
    if [ -e "/proc/$PID/cwd" ]
    then
        $TERMINAL -cd $(readlink /proc/$PID/cwd) & disown ;
    else
        $TERMINAL & disown ;
    fi
}

# lumerical fdtd
export PATH="/opt/lumerical/fdtd/bin:$PATH"
fdtd() {
    /opt/lumerical/fdtd/bin/fdtd-solutions $1 &>/dev/null &disown ;
}

# klayout
klayout() { /usr/bin/klayout -e "$@" &>/dev/null &disown ;}

# clean git history
git-clean-history(){ echo git filter-branch --force --index-filter \'git rm -rf --cached --ignore-unmatch $1\' --prune-empty --tag-name-filter cat -- --all ;}

# scihub downloader
shdl() { curl -O $(curl -s http://sci-hub.tw/"$@" | grep location.href | grep -o http.*pdf) ;}

# chromium apps
ca() { chromium --app=http://"$@" &>/dev/null &disown ;}
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
alias gmail1="ca mail.google.com/mail/u/1/"
alias gmail2="ca mail.google.com/mail/u/2/"
alias maps="ca maps.google.com"
alias overleaf="ca overleaf.com"
alias calendar="ca calendar.google.com"

# add color to common commands
alias ls='ls -hN --color=auto --group-directories-first'
alias grep="grep --color=auto"
alias ccat="highlight --out-format=ansi"

# internet
alias yt="youtube-dl --add-metadata -ic" # Download video link
alias yta="yt -x -f bestaudio/best" # Download only audio
alias YT="youtube-viewer"
alias ethspeed="speedometer -r enp0s25"
alias wifispeed="speedometer -r wlp3s0"
alias starwars="telnet towel.blinkenlights.nl"

# redate git commits
export PATH="/home/flori/.git-redate:$PATH"

# fuzzy file finder (fzf command)
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Anaconda python
export PATH="$HOME/.anaconda/bin:$PATH"
export CC="gcc"
export CXX="g++"

# Citrix ICA
export ICAROOT="/home/flori/.ica"

# Python Path (get the pythonpath from ~/.pythonpath)
export PYTHONPATH="$(tr '\n' ':' < ~/.pythonpath | head -c -1)"
export PYTHONPATH="${PYTHONPATH//\~/$HOME}"

