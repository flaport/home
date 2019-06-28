#!/usr/bin/env zsh
#    _____ _     ____  ____  ____  ____  _____
#   /    // \   /  _ \/  __\/  _ \/  __\/__ __\
#   |  __\| |   | / \||  \/|| / \||  \/|  / \
#   | |   | |_/\| |-|||  __/| \_/||    /  | |
#   \_/   \____/\_/ \|\_/   \____/\_/\_\  \_/

# zsh Initialization
## ------------------------------------------------------------------------------

# Path to your oh-my-zsh installation (install with yay!).
ZSH=/usr/share/oh-my-zsh

# zsh folder for custom scripts:
ZSH_CUSTOM=$HOME/.config/zsh

# Set name of the theme to load, random=random choice from predefined list.
[[ $(tty) == /dev/tty* ]] && ZSH_THEME=dieter || ZSH_THEME=powerline
ZSH_THEME_RANDOM_CANDIDATES=( robbyrussell agnoster dieter powerline )

# case-sensitive completion.
CASE_SENSITIVE=false

# hyphen-insensitive completion (case-sensitive should be false)
HYPHEN_INSENSITIVE=true

# bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE=true
DISABLE_UPDATE_PROMPT=false

# magic functions
DISABLE_MAGIC_FUNCTIONS=false

# colored ls
DISABLE_LS_COLORS=false

# automatic terminal title
DISABLE_AUTO_TITLE=false

# command auto correction (annoying)
ENABLE_CORRECTION=false

# display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS=true

# mark untracked files as dirty (status checks much faster if disabled)
DISABLE_UNTRACKED_FILES_DIRTY=false

# history timestamp format
HIST_STAMPS="yyyy-mm-dd"

# plugins to load:
plugins=( 
    autojump
    colorize
    colored-man-pages
    command-not-found
    compleat
    copydir
    copyfile
    common-aliases
    git 
    pip
    pylint
    python
    vi-mode
    fzf
)

source $ZSH/oh-my-zsh.sh

# remove some of the common aliases
unalias cp
unalias mv
unalias rm

# some vim-like aliases:
alias :q=exit
alias :x=exit
alias :e=$EDITOR


## Fish-like autosuggestions
#-------------------------------------------------------------------------------

ZSH_AUTOSUGGESTIONS=$HOME/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
[ -f $ZSH_AUTOSUGGESTIONS ] && source $ZSH_AUTOSUGGESTIONS
bindkey '^p' autosuggest-accept #-execute
bindkey '^n' autosuggest-accept #-execute


## Python
#-------------------------------------------------------------------------------
# create python startup file if it does not exist
touch $HOME/.pythonpath
# create python path file if it does not exist
touch $HOME/.pythonstartup
# set python path from "~/.pythonpath" file
export PYTHONPATH="$(tr '\n' ':' < ~/.pythonpath | head -c -1 | sed 's|~|'$HOME'|g')"
# enable conda commands
source "/home/flaport/.anaconda/etc/profile.d/conda.sh"

