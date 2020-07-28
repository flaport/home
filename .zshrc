#!/usr/bin/zsh
#    _____ _     ____  ____  ____  ____  _____
#   /    // \   /  _ \/  __\/  _ \/  __\/__ __\
#   |  __\| |   | / \||  \/|| / \||  \/|  / \
#   | |   | |_/\| |-|||  __/| \_/||    /  | |
#   \_/   \____/\_/ \|\_/   \____/\_/\_\  \_/

## General settings
#-------------------------------------------------------------------------------

# source function (ignore file if file does not exist)
function sourcefile {
    [[ -f $1 ]] && source $1
}

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

# colored man pages:
man() {
    LESS_TERMCAP_md=$'\e[01;31m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[01;44;33m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[01;32m' \
    command man "$@"
}

# go backward and forward in history (equivalent to up/down arrow)
bindkey "^[h" up-line-or-history # alt + h
bindkey "^[l" down-line-or-history # alt + l
bindkey "^y" "" # noop

# prompt and cursor shape based on vi mode
setopt prompt_subst
prompt(){
    retval=$1
    # is root user
    [[ $UID == 0 ]] && echo -ne "%B%F{yellow}%{%G %}%f%b "
    # conda info
    if [[ ! -z $CONDA_DEFAULT_ENV ]]; then
        echo -ne "%F{blue}%{%G %}%f" # 
        [[ $CONDA_DEFAULT_ENV != base ]] && echo -ne "%F{blue}$CONDA_DEFAULT_ENV%f " || echo -ne "%F{blue}%f"
    fi
    # path
    echo -ne "%F{cyan}%(4~|%-1~/…/%2~|%3~)/%f " # 
    # git info
    if git rev-parse --is-inside-work-tree 2> /dev/null | grep true &> /dev/null; then
        branch_name=$(git branch --show-current | sed s/master//)
        echo -ne "%F{magenta}%{%G%}$branch_name%f " #  
    fi
    # prompt symbol
    [[ $retval == 0 ]] && echo -ne "%B%F{green}%{%G❭%}%f%b " || echo -ne "%B%F{red}%{%G❭%}%f%b " # ➜ ❭
    [[ ! -z $CONDA_DEFAULT_ENV ]] && echo " " # necessary bc of the python ( ) symbol.
}
rprompt(){
    retval=$1
    # return value
    [[ $retval != 0 ]] && echo -ne "%B%F{red}[$retval]%f%b "
    # user@host
    if [[ $UID == 0 ]]; then
       echo -ne "%B%F{red}$USER%f%b"
    else
        [[ $UID != 1000 || -n $SSH_CLIENT ]] && echo -ne "%F{yellow}$USER%f"
    fi
    if [[ -n $SSH_CLIENT ]]; then
       echo -ne "@%F{blue}$HOST%f"
    else
       echo -ne "    " # spacer
    fi
}
PROMPT="$(prompt 0)"
RPROMPT="$(rprompt 0)"
NORMAL='\e[1 q\e\\' # █
INSERT='\e[4 q\e\\' # _   - INSERT='\e[5 q\e\\' # |
[ -z $NVIM_LISTEN_ADDRESS ] || INSERT=$NORMAL
echo -ne $INSERT
function zle-keymap-select { # gets run every time the mode changes
    if [[ ${KEYMAP} == vicmd ]] || [[ $1 = 'block' ]]; then
        echo -ne $NORMAL
    elif [[ ${KEYMAP} == main ]] || [[ ${KEYMAP} == viins ]] || [[ ${KEYMAP} = '' ]] || [[ $1 = 'beam' ]]; then
        echo -ne $INSERT
    fi
    zle reset-prompt
}
function zle-line-init() { # gets run every new line
    retval="$?" # should obviously always be first
    echo -ne $INSERT
    PROMPT="$(prompt $retval)"
    RPROMPT="$(rprompt $retval)"
    zle reset-prompt
}
function preexec() { # gets run at new prompt.
    echo -ne $INSERT
}
zle -N zle-keymap-select
zle -N zle-line-init

## Aliases
#-------------------------------------------------------------------------------
alias :q=exit
alias :x=exit
alias :e=$EDITOR
alias ll="ls -l"
alias la="ls -la"
alias grep="grep --color=auto"
alias base="conda activate base"
alias system="conda deactivate && conda deactivate"
alias history="history 1"
alias pip="pip --no-cache-dir"


## Python
#-------------------------------------------------------------------------------

# enable conda commands but do not activate conda
sourcefile "$HOME/.anaconda/etc/profile.d/conda.sh"


## Extensions
#-------------------------------------------------------------------------------

# broot (fuzzy file finder/jumper/...)
sourcefile $HOME/.config/broot/launcher/bash/br

# autojump
sourcefile $HOME/.config/autojump/share/autojump/autojump.zsh

# my custom autojump commands (slightly different from default behavior):
sourcefile $HOME/.scripts/autojump/autojump-improved.zsh

# zsh autosuggestions (like in the fish shell)
sourcefile $HOME/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
bindkey '^p' autosuggest-accept #-execute
bindkey '^n' autosuggest-accept #-execute

# stderr in red; should be last.
[ -f $HOME/.config/stderred/build/libstderred.so ] && export LD_PRELOAD="$HOME/.config/stderred/build/libstderred.so${LD_PRELOAD:+:$LD_PRELOAD}"

# Load zsh-syntax-highlighting; should be last.
sourcefile $HOME/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

