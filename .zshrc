#!/usr/bin/zsh
#    _____ _     ____  ____  ____  ____  _____
#   /    // \   /  _ \/  __\/  _ \/  __\/__ __\
#   |  __\| |   | / \||  \/|| / \||  \/|  / \
#   | |   | |_/\| |-|||  __/| \_/||    /  | |
#   \_/   \____/\_/ \|\_/   \____/\_/\_\  \_/


## General settings
#-------------------------------------------------------------------------------

# enable colors
autoload -U colors && colors

# better tab-completion
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# vi mode
bindkey -v
export KEYTIMEOUT=1

# change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\033[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\033[4 q' # '\033[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne '\033[4 q'
}
zle -N zle-line-init
echo -ne '\033[4 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\033[4 q' ;} # Use beam shape cursor for each new prompt.

# colored zsh prompt
setopt prompt_subst
if [[ $(tty) == /dev/tty* ]]; then
    source $HOME/.config/zsh/themes/dieter.zsh
else
    source ~/.config/zsh/themes/powerline.zsh
fi

## Aliases
#-------------------------------------------------------------------------------
alias :q=exit
alias :x=exit
alias :e=$EDITOR
alias grep="grep --color=auto"
alias base="conda activate base"
alias system="conda deactivate && conda deactivate"


## Python
#-------------------------------------------------------------------------------
# create python startup file if it does not exist
touch $HOME/.pythonpath
# create python path file if it does not exist
touch $HOME/.pythonstartup
# set python path from "~/.pythonpath" file
export PYTHONPATH="$(tr '\n' ':' < ~/.pythonpath | head -c -1 | sed 's|~|'$HOME'|g')"
# enable conda commands but do not activate conda
source "$HOME/.anaconda/etc/profile.d/conda.sh"


## Extensions
#-------------------------------------------------------------------------------

# autojump
source /usr/share/autojump/autojump.zsh

# zsh autosuggestions (like in the fish shell)
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
bindkey '^p' autosuggest-accept #-execute
bindkey '^n' autosuggest-accept #-execute

# Load zsh-syntax-highlighting; should be last.
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

