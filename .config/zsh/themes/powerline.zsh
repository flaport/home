#!/usr/bin/env zsh
#    _____ _     ____  ____  ____  ____  _____
#   /    // \   /  _ \/  __\/  _ \/  __\/__ __\
#   |  __\| |   | / \||  \/|| / \||  \/|  / \
#   | |   | |_/\| |-|||  __/| \_/||    /  | |
#   \_/   \____/\_/ \|\_/   \____/\_/\_\  \_/

# Powerline theme - a fork of the agnoster theme.


# important settings if UTF-8 is not enabled system-wide:
LC_ALL=""
LC_CTYPE="en_US.UTF-8"

# special characters. There are two ways to obtain special characters:
#   1. Use awesome terminal fonts + powerline-fonts
#   2. Use a patched font such as nerd-fonts-inconsolataGo
#   option 1 was chosen
PL_BRANCH='' # <- powerline-fonts | awesome-terminal-fonts -> '  '
PL_SEGMENT='' # <- powerline-fonts | awesome-terminal-fonts -> '' (too small)
PL_FAILED='' # <- awesome-terminal-fonts | any monospace font -> '✘'
PL_ROOT='' # <- awesome-terminal-fonts | any monospace font -> '⚡'
PL_MERGE='' # <- awesome-terminal-fonts
PL_REBASE='' # <- awesome-terminal-fonts
PL_LOG='' # <- awesome-terminal-fonts
PL_BATTERY1='' # <- awesome-terminal-fonts | any monospace font -> '🔋'
PL_BATTERY2='' # <- awesome-terminal-fonts | any monospace font -> '🔋'
PL_BATTERY3='' # <- awesome-terminal-fonts | any monospace font -> '🔋'
PL_BATTERY4='' # <- awesome-terminal-fonts | any monospace font -> '🔋'
PL_BATTERY5='' # <- awesome-terminal-fonts | any monospace font -> '🔋'
PL_CHARGING='🔌' # <- any monospace font -> '🔌'
PL_DIRTY='!' #' ' # <- any monospace font
PL_STAGED='=' # ' ' # <- any monospace font

# Xresources colors
COLOR1=6  # first color
COLOR2=4  # second color
COLORD=5  # dirty color
COLORU=1  # urgent color
COLORT=7  # text color

prompt_segment() {
    local bg fg colorbg

    # get the background color for the prompt
    [[ -n $1 ]] && colorbg=$1 || colorbg=$COLOR1

    # create the prompt background
    if [[ -n $COLORBG && $colorbg != $COLORBG ]]; then
        echo -n " %{%K{$colorbg}%F{$COLORBG}%}$PL_SEGMENT%{%F{$COLORT}%} "
    else
        echo -n "%{%K{$colorbg}%}%{%F{$COLORT}%} "
    fi

    # save the last used background color for the next prompt segment
    COLORBG=$colorbg

    # if colorbg is one of the two main colors, switch them around:
    if [[ $colorbg == $COLOR1 || $colorbg == $COLOR2 ]]; then
        colorbg=$COLOR1
        COLOR1=$COLOR2
        COLOR2=$colorbg
    fi
}

# End the prompt, closing any open segments
prompt_end() {
  if [[ -n $COLORBG ]]; then
    echo -n " %{%k%F{$COLORBG}%}$PL_SEGMENT"
  else
    echo -n "%{%k%}"
  fi
  echo -n "%{%f%}"
  COLORBG=''
  echo -n " "
}

# Context: user@hostname (who am I and where am I)
prompt_context() {
  if [[ "$USER" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then
    prompt_segment
    echo -n "%(!.%{%F{yellow}%}.)%n@%m"
  fi
}

# Git: branch/detached head, dirty status
prompt_git() {
  (( $+commands[git] )) || return
  if [[ "$(git config --get oh-my-zsh.hide-status 2>/dev/null)" = 1 ]]; then
    return
  fi

  local ref dirty mode repo_path

  if $(git rev-parse --is-inside-work-tree >/dev/null 2>&1); then
    repo_path=$(git rev-parse --git-dir 2>/dev/null)
    git status | grep "working tree clean" &> /dev/null
    dirty=$?
    ref=$(git symbolic-ref HEAD 2> /dev/null) || ref="➦ $(git rev-parse --short HEAD 2> /dev/null)"
    if [[ $dirty -eq 0 ]]; then
      prompt_segment
    else
      prompt_segment $COLORD
    fi

    if [[ -e "${repo_path}/BISECT_LOG" ]]; then
      mode=" $PL_LOG"
    elif [[ -e "${repo_path}/MERGE_HEAD" ]]; then
      mode=" $PL_MERGE"
    elif [[ -e "${repo_path}/rebase" || -e "${repo_path}/rebase-apply" || -e "${repo_path}/rebase-merge" || -e "${repo_path}/../.dotest" ]]; then
      mode=" $PL_REBASE"
    fi

    setopt promptsubst
    autoload -Uz vcs_info

    zstyle ':vcs_info:*' enable git
    zstyle ':vcs_info:*' get-revision true
    zstyle ':vcs_info:*' check-for-changes true
    zstyle ':vcs_info:*' stagedstr "$PL_STAGED" # '+' #'✚'
    zstyle ':vcs_info:*' unstagedstr "$PL_DIRTY" #'.' #'●'
    zstyle ':vcs_info:*' formats ' %u%c'
    zstyle ':vcs_info:*' actionformats ' %u%c'
    vcs_info
    branch_name=$(echo ${ref/refs\/heads\//$PL_BRANCH } | sed s/\ master$//g)
    echo -n "$branch_name${vcs_info_msg_0_%% }${mode}"
  fi
}

prompt_hg() {
  (( $+commands[hg] )) || return

  local rev st branch

  if $(hg id >/dev/null 2>&1); then
    if $(hg prompt >/dev/null 2>&1); then
      if [[ $(hg prompt "{status|unknown}") = "?" ]]; then
        # if files are not added
        prompt_segment $COLORD
        st='±'
      elif [[ -n $(hg prompt "{status|modified}") ]]; then
        # if any modification
        prompt_segment $COLORD
        st='±'
      else
        # if working copy is clean
        prompt_segment
      fi
      echo -n $(hg prompt "☿ {rev}@{branch}") $st
    else
      st=""
      rev=$(hg id -n 2>/dev/null | sed 's/[^-0-9]//g')
      branch=$(hg id -b 2>/dev/null)
      if `hg st | grep -q "^\?"`; then
        prompt_segment $COLORD
        st='±'
      elif `hg st | grep -q "^[MA]"`; then
        prompt_segment $COLORD
        st='±'
      else
        prompt_segment
      fi
      echo -n "☿ $rev@$branch" $st
    fi
  fi
}

# Dir: full path of current working directory
prompt_dir() {
  prompt_segment
  echo -n '%~'
}

# Dir: name of current working directory
prompt_dir_short() {
  prompt_segment
  echo -n $(basename $PWD | sed s/$USER/~/)
}

# Virtualenv: current working virtualenv
prompt_virtualenv() {
  local virtualenv_path="$VIRTUAL_ENV"
  if [[ -n $virtualenv_path && -n $VIRTUAL_ENV_DISABLE_PROMPT ]]; then
      env="(`basename $virtualenv_path`)"
  fi
  if [[ -n $CONDA_DEFAULT_ENV ]]; then
      env=$CONDA_DEFAULT_ENV
  fi
  [ -z "$env" ] && return
  prompt_segment
  echo -n $env
}

# Jobs: are there any jobs open (ctrl-z)
prompt_jobs() {
  local -a symbols
  [[ $(jobs -l | wc -l 2> /dev/null) -gt 0 ]] && symbols+="%{%F{$COLORT}%}$(echo $(jobs -l | grep -oE '\[[0-9]*\]' | sed 's/\]//g' | sed 's/\[//g' ))"
  [ -z "$symbols" ] && return
  prompt_segment
  echo -n "$symbols"
}

# Status:
# - was there an error
# - am I root
prompt_status() {
  local -a symbols

  [[ $RETVAL != 0 && $RETVAL != 148 ]] && symbols+="%{%F{$COLORT}%}$PL_FAILED  $RETVAL"
  [[ $UID -eq 0 ]] && symbols+="%{%F{$COLORT}%}$PL_ROOT"

  [ -z "$symbols" ] && return
  prompt_segment $COLORU
  echo -n "$symbols"
}

prompt_battery(){
    battery=$(acpi -b 2> /dev/null)
    percentage=$(echo $battery |  sed 's/^.*, \([0-9]*\)%.*$/\1/g')
    [ -z $percentage ] && return
    bgcolor=$COLOR1
    icon=$PL_CHARGING
    if echo $battery | grep "Charging" &> /dev/null; then
       prompt_segment
       echo -n $icon
       return
    fi
    if [[ $percentage -gt 90 ]]; then
        return
    elif [[ $percentage -gt 60 ]]; then
        icon=$PL_BATTERY2
    elif [[ $percentage -gt 30 ]]; then
        icon=$PL_BATTERY3
    elif [[ $percentage -gt 5 ]]; then
        icon=$PL_BATTERY4
    else
        bgcolor=$COLORU
        icon=$PL_BATTERY5
    fi
    prompt_segment $bgcolor
    echo -n $icon" "
}

## Main prompt
build_prompt_full() {
  RETVAL=$?
  prompt_status
  prompt_jobs
  prompt_battery
  prompt_virtualenv
  prompt_dir
  prompt_git
  prompt_end
}

build_prompt_short() {
  prompt_virtualenv
  prompt_dir_short
  prompt_end
}


sp() { # short prompt
    PROMPT='$(build_prompt_short)'
    clear
}

fp() { # full prompt
    PROMPT='$(build_prompt_full)'
    clear
}

PROMPT='$(build_prompt_full)'

