#!/usr/bin/env zsh
#    _____ _     ____  ____  ____  ____  _____
#   /    // \   /  _ \/  __\/  _ \/  __\/__ __\
#   |  __\| |   | / \||  \/|| / \||  \/|  / \
#   | |   | |_/\| |-|||  __/| \_/||    /  | |
#   \_/   \____/\_/ \|\_/   \____/\_/\_\  \_/
#
# Powerline theme - a fork of the agnoster theme.
#

# Special Powerline characters
() {
  local LC_ALL="" LC_CTYPE="en_US.UTF-8"
  SEGMENT_SEPARATOR=$'\ue0b0'
}

# colors
# COLOR1 and COLOR2 will be switched at the end of each segment
COLOR1=4  # first color
COLOR2=6  # second color
COLORU=13  # urgent color
COLORT=15 # text colors


prompt_segment() {
    local bg fg colorbg

    # get the background color for the prompt
    [[ -n $1 ]] && colorbg=$1 || colorbg=$COLOR1

    # create the prompt background
    if [[ -n $COLORBG && $colorbg != $COLORBG ]]; then
        echo -n " %{%K{$colorbg}%F{$COLORBG}%}$SEGMENT_SEPARATOR%{%F{$COLORT}%} "
    else
        echo -n "%{%K{$colorbg}%}%{%F{$COLORT}%} "
    fi

    # save the last used background color for the next prompt segment
    COLORBG=$colorbg

    # switch COLOR1 and COLOR2
    colorbg=$COLOR1
    COLOR1=$COLOR2
    COLOR2=$colorbg
}

# End the prompt, closing any open segments
prompt_end() {
  if [[ -n $COLORBG ]]; then
    echo -n " %{%k%F{$COLORBG}%}$SEGMENT_SEPARATOR"
  else
    echo -n "%{%k%}"
  fi
  echo -n "%{%f%}"
  COLORBG=''
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
  local PL_BRANCH_CHAR
  () {
    local LC_ALL="" LC_CTYPE="en_US.UTF-8"
    PL_BRANCH_CHAR=$'\ue0a0'         # 
  }
  local ref dirty mode repo_path

  if $(git rev-parse --is-inside-work-tree >/dev/null 2>&1); then
    repo_path=$(git rev-parse --git-dir 2>/dev/null)
    dirty=$(parse_git_dirty)
    ref=$(git symbolic-ref HEAD 2> /dev/null) || ref="➦ $(git rev-parse --short HEAD 2> /dev/null)"
    if [[ -n $dirty ]]; then
      prompt_segment $COLORU
    else
      prompt_segment
    fi

    if [[ -e "${repo_path}/BISECT_LOG" ]]; then
      mode=" <B>"
    elif [[ -e "${repo_path}/MERGE_HEAD" ]]; then
      mode=" >M<"
    elif [[ -e "${repo_path}/rebase" || -e "${repo_path}/rebase-apply" || -e "${repo_path}/rebase-merge" || -e "${repo_path}/../.dotest" ]]; then
      mode=" >R>"
    fi

    setopt promptsubst
    autoload -Uz vcs_info

    zstyle ':vcs_info:*' enable git
    zstyle ':vcs_info:*' get-revision true
    zstyle ':vcs_info:*' check-for-changes true
    zstyle ':vcs_info:*' stagedstr '+' #'✚'
    zstyle ':vcs_info:*' unstagedstr '.' #'●'
    zstyle ':vcs_info:*' formats ' %u%c'
    zstyle ':vcs_info:*' actionformats ' %u%c'
    vcs_info
    echo -n "${ref/refs\/heads\//$PL_BRANCH_CHAR }${vcs_info_msg_0_%% }${mode}"
  fi
}

prompt_hg() {
  (( $+commands[hg] )) || return
  local rev st branch
  if $(hg id >/dev/null 2>&1); then
    if $(hg prompt >/dev/null 2>&1); then
      if [[ $(hg prompt "{status|unknown}") = "?" ]]; then
        # if files are not added
        prompt_segment $COLORU
        st='±'
      elif [[ -n $(hg prompt "{status|modified}") ]]; then
        # if any modification
        prompt_segment $COLORU
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
        prompt_segment $COLORU
        st='±'
      elif `hg st | grep -q "^[MA]"`; then
        prompt_segment $COLORU
        st='±'
      else
        prompt_segment
      fi
      echo -n "☿ $rev@$branch" $st
    fi
  fi
}

# Dir: current working directory
prompt_dir() {
  prompt_segment
  echo -n '%~'
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
  if [[ -n $env ]]; then
    prompt_segment
    echo -n $env
  fi
}

# Status:
# - was there an error
# - am I root
# - are there background jobs?
prompt_status() {
  local -a symbols

  [[ $RETVAL -ne 0 ]] && symbols+="%{%F{15}%}✘"
  [[ $UID -eq 0 ]] && symbols+="%{%F{15}%}⚡"
  [[ $(jobs -l | wc -l) -gt 0 ]] && symbols+="%{%F{15}%}$(echo $(jobs -l | grep -oE '\[[0-9]*\]'))"

  if [[ -n "$symbols" ]]; then
      prompt_segment
      echo -n "$symbols"
  fi
}

prompt_battery(){
    BATTERY=$(acpi -b 2> /dev/null)
    BATTERY=$(echo $BATTERY | sed "s/^.*: //" | sed "s/^Full,.*$//")
    BATTERY=$(echo $BATTERY | sed "s/^Discharging, /🔋/" | sed "s/^Unknown, /🔋/" | sed "s/^Charging, /🔌/" | sed "s/^\(.*\)%,.*/\1%%/")
    [ ! -z $BATTERY ] && prompt_segment && echo -n "$BATTERY"
}


## Main prompt
build_prompt() {
  RETVAL=$?
  prompt_status
  prompt_battery
  prompt_virtualenv
  prompt_dir
  prompt_git
  prompt_end
}

#PROMPT='%{%f%b%k%}$(build_prompt) '
PROMPT='$(build_prompt) '
