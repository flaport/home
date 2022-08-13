#!/usr/bin/zsh
#    _____ _     ____  ____  ____  ____  _____
#   /    // \   /  _ \/  __\/  _ \/  __\/__ __\
#   |  __\| |   | / \||  \/|| / \||  \/|  / \
#   | |   | |_/\| |-|||  __/| \_/||    /  | |
#   \_/   \____/\_/ \|\_/   \____/\_/\_\  \_/


## General settings
#-------------------------------------------------------------------------------

export LANG=en_US.UTF-8

# source function (ignore file if file does not exist)
function sourcefile {
    [[ -f "$1" ]] && source "$1"
}

# source settings not in source control
sourcefile $HOME/.zshrc2

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

# go backward and forward in history (equivalent to up/down arrow)
bindkey "^[h" up-line-or-history # alt + h
bindkey "^[l" down-line-or-history # alt + l
bindkey "^y" "" # noop

# reverse history search
bindkey -v
bindkey '^R' history-incremental-search-backward

# complecation related settings
# Define completers
zstyle ':completion:*' completer _extensions _complete _approximate
# Autocomplete options for cd instead of directory stack
zstyle ':completion:*' complete-options true
# zstyle ':completion:*' file-sort modification
zstyle ':completion:*:*:*:*:corrections' format '%F{yellow}!- %d (errors: %e) -!%f'
zstyle ':completion:*:*:*:*:descriptions' format '%F{blue}-- %D %d --%f'
# # Colors for files and directory
zstyle ':completion:*' file-list all
# # See ZSHCOMPWID "completion matching control"
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle -e ':completion:*:(ssh|scp|sftp|rsh|rsync):hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'


# prompt and cursor shape based on vi mode
setopt prompt_subst
prompt(){
    retval=$1
    # is root user
    [[ $UID == 0 ]] && echo -ne "%B%F{yellow}%{%G%} %f%b "
    # conda info
    if [[ ! -z $CONDA_DEFAULT_ENV ]]; then
        echo -ne "%F{blue}%{%G%} %f" # 
        [[ $CONDA_DEFAULT_ENV != base ]] && echo -ne "%F{blue}$CONDA_DEFAULT_ENV%f "
    fi
    # path
    [[ $PWD == "/" ]] && echo -ne "%F{cyan}/%f " || echo -ne "%F{cyan}%(4~|%-1~/…/%2~|%3~)/%f " # 
    # git info
    if git rev-parse --is-inside-work-tree 2> /dev/null | grep true &> /dev/null; then
        branch_name=$(git branch --show-current | sed s/master//)
        dirty=" "
        if git status --porcelain 2> /dev/null | grep "^A\|^M\|^ M\|^??" > /dev/null 2> /dev/null; then
            dirty="*"
        fi
        echo -ne "%F{magenta}%{%G%}$branch_name$dirty%f" #  
    fi
    # prompt symbol
    [[ $retval == 0 ]] && echo -ne "%B%F{green}%{%G❭%}%f%b " || echo -ne "%B%F{red}%{%G❭%}%f%b " # ➜ ❭
}
rprompt(){
    retval=$1
    # return value
    [[ $retval != 0 ]] && echo -ne "%B%F{red}[$retval]%f%b "
    # user@host
    if [[ $UID == 0 ]]; then
       echo -ne "%B%F{red}root%f%b"
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
alias ss="sudo systemctl"
alias ll="ls -l"
alias la="ls -la"
alias grep="grep --color=auto"
alias base="conda activate base"
alias system="conda deactivate && conda deactivate"
alias history="history 1"
alias D="dunk | less -R"

alias pip="python -m pip --no-cache-dir"
alias pip3="python3 -m pip --no-cache-dir"
alias pip2="python2 -m pip --no-cache-dir"

alias spip="sudo /usr/bin/python -m pip --no-cache-dir"
alias spip3="sudo /usr/bin/python3 -m pip --no-cache-dir"
alias spip2="sudo /usr/bin/python2 -m pip --no-cache-dir"

# prevent having to escape square brackets
alias rake="noglob rake"

man() { # colored man pages:
    LESS_TERMCAP_md=$'\e[01;31m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[01;44;33m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[01;32m' \
    command man "$@"
}


## Extensions
#-------------------------------------------------------------------------------

# conda (scientific python distribution and environments)
sourcefile "$HOME/.anaconda/etc/profile.d/conda.sh"
if [ -f "$HOME/.anaconda/etc/profile.d/mamba.sh" ]; then
  source "$HOME/.anaconda/etc/profile.d/mamba.sh"
  alias conda=mamba
fi

# travis (continuous integration)
sourcefile "$HOME/.travis/travis.sh"

# broot (fuzzy file finder/jumper/...)
sourcefile $HOME/.config/broot/launcher/bash/br

# autojump
sourcefile $HOME/.config/autojump/share/autojump/autojump.zsh

# my custom autojump commands (slightly different from default behavior):
sourcefile $HOME/.scripts/autojump/autojump-improved.zsh

# zsh autosuggestions (like in the fish shell)
sourcefile $HOME/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
typeset -g ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=7'
bindkey '^p' autosuggest-accept #-execute
bindkey '^n' autosuggest-accept #-execute
bindkey '^o' autosuggest-toggle # enable/disable autosuggest

# stderr in red; should be last.
[ -f $HOME/.config/stderred/build/libstderred.so ] && export LD_PRELOAD="$HOME/.config/stderred/build/libstderred.so${LD_PRELOAD:+:$LD_PRELOAD}"
ghci(){LD_PRELOAD="" /usr/bin/ghci "$@"}
stack(){LD_PRELOAD="" /usr/bin/stack "$@"}
apl(){LD_PRELOAD="" /usr/bin/apl "$@"}

# Load zsh-syntax-highlighting; should be last.
sourcefile $HOME/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
