#
# Spaceship ZSH
#
# Author: Denys Dovhan, denysdovhan.com
# License: MIT
# https://github.com/denysdovhan/spaceship-prompt
#
# configured for arch-home by flaport
#

SPACESHIP_ROOT="/usr/lib/spaceship-prompt/"

if [ ! -d "$SPACESHIP_ROOT" ]; then
    >&2 echo "spaceship not installed. Please install spaceship from the AUR:"
    >&2 echo
    >&2 echo "yay -S spaceship-prompt-git"
    >&2 echo
    >&2 echo "falling back to theme 'dieter'"
    source $HOME/.config/zsh/themes/dieter.zsh
    return
fi

# ------------------------------------------------------------------------------
# CONFIGURATION
# The default configuration that can be overridden in .zshrc
# ------------------------------------------------------------------------------

SPACESHIP_PROMPT_ORDER=(
    # time          # Time stampts section
    user          # Username section
    dir           # Current directory section
    # host          # Hostname section
    # hg            # Mercurial section (hg_branch  + hg_status)
    # package       # Package version
    # node          # Node.js section
    # ruby          # Ruby section
    # elm           # Elm section
    # elixir        # Elixir section
    # xcode         # Xcode section
    # swift         # Swift section
    # golang        # Go section
    # php           # PHP section
    # rust          # Rust section
    # haskell       # Haskell Stack section
    # julia         # Julia section
    # docker        # Docker section
    # aws           # Amazon Web Services section
    # dotnet        # .NET section
    # ember         # Ember.js section
    # kubectl       # Kubectl context section
    # terraform     # Terraform workspace section
    exit_code     # Exit code section
    char          # Prompt character
)

SPACESHIP_RPROMPT_ORDER=(
    # vi_mode       # Vi-mode indicator
    git           # Git section (git_branch + git_status)
    venv          # virtualenv section
    conda         # conda virtualenv section
    pyenv         # Pyenv section
    jobs
    exec_time     # Execution time
    battery       # Battery level and status
)

# PROMPT
SPACESHIP_PROMPT_ADD_NEWLINE=false
SPACESHIP_PROMPT_SEPARATE_LINE=false
SPACESHIP_PROMPT_FIRST_PREFIX_SHOW=false
SPACESHIP_PROMPT_PREFIXES_SHOW=false
SPACESHIP_PROMPT_SUFFIXES_SHOW=true
SPACESHIP_PROMPT_DEFAULT_PREFIX=""
SPACESHIP_PROMPT_DEFAULT_SUFFIX=" "

# ------------------------------------------------------------------------------
# LIBS
# Spaceship utils/hooks/etc
# ------------------------------------------------------------------------------

# Load utils
source "$SPACESHIP_ROOT/lib/utils.zsh"

# load hooks
source "$SPACESHIP_ROOT/lib/hooks.zsh"

# load section utils
source "$SPACESHIP_ROOT/lib/section.zsh"

# ------------------------------------------------------------------------------
# SECTIONS
# Sourcing sections the prompt consists of
# ------------------------------------------------------------------------------

for section in $(spaceship::union $SPACESHIP_PROMPT_ORDER $SPACESHIP_RPROMPT_ORDER); do
  if [[ -f "$SPACESHIP_ROOT/sections/$section.zsh" ]]; then
    source "$SPACESHIP_ROOT/sections/$section.zsh"
  elif spaceship::defined "spaceship_$section"; then
    # Custom section is declared, nothing else to do
    continue
  else
    echo "Section '$section' have not been loaded."
  fi
done

# ------------------------------------------------------------------------------
# PROMPTS
# An entry point of prompt
# ------------------------------------------------------------------------------

# PROMPT
# Primary (left) prompt
spaceship_prompt() {
  # Retrieve exit code of last command to use in exit_code
  # Must be captured before any other command in prompt is executed
  # Must be the very first line in all entry prompt functions, or the value
  # will be overridden by a different command execution - do not move this line!
  RETVAL=$?

  # Should it add a new line before the prompt?
  [[ $SPACESHIP_PROMPT_ADD_NEWLINE == true ]] && echo -n "$NEWLINE"
  spaceship::compose_prompt $SPACESHIP_PROMPT_ORDER
}

# $RPROMPT
# Optional (right) prompt
spaceship_rprompt() {
  # Retrieve exit code of last command to use in exit_code
  RETVAL=$?

  spaceship::compose_prompt $SPACESHIP_RPROMPT_ORDER
}

# PS2
# Continuation interactive prompt
spaceship_ps2() {
  # Retrieve exit code of last command to use in exit_code
  RETVAL=$?

  local char="${SPACESHIP_CHAR_SYMBOL_SECONDARY="$SPACESHIP_CHAR_SYMBOL"}"
  spaceship::section "$SPACESHIP_CHAR_COLOR_SECONDARY" "$char"
}

# ------------------------------------------------------------------------------
# SETUP
# Setup requirements for prompt
# ------------------------------------------------------------------------------

# Runs once when user opens a terminal
# All preparation before drawing prompt should be done here
prompt_spaceship_setup() {
  autoload -Uz vcs_info
  autoload -Uz add-zsh-hook

  # This variable is a magic variable used when loading themes with zsh's prompt
  # function. It will ensure the proper prompt options are set.
  prompt_opts=(cr percent sp subst)

  # Borrowed from promptinit, sets the prompt options in case the prompt was not
  # initialized via promptinit.
  setopt noprompt{bang,cr,percent,subst} "prompt${^prompt_opts[@]}"

  # Add exec_time hooks
  add-zsh-hook preexec spaceship_exec_time_preexec_hook
  add-zsh-hook precmd spaceship_exec_time_precmd_hook

  # Disable python virtualenv environment prompt prefix
  VIRTUAL_ENV_DISABLE_PROMPT=true

  # Configure vcs_info helper for potential use in the future
  add-zsh-hook precmd spaceship_exec_vcs_info_precmd_hook
  zstyle ':vcs_info:*' enable git
  zstyle ':vcs_info:git*' formats '%b'

  # Expose Spaceship to environment variables
  PROMPT='$(spaceship_prompt)'
  PS2='$(spaceship_ps2)'
  RPS1='$(spaceship_rprompt)'
}

# ------------------------------------------------------------------------------
# ENTRY POINT
# An entry point of prompt
# ------------------------------------------------------------------------------

# Pass all arguments to the spaceship_setup function
prompt_spaceship_setup "$@"
