## fish greeting (suppressed)
function fish_greeting
end

# turn on vim mode
fish_vi_key_bindings
# fish_default_key_bindings

## environment variables
set -gx CC "gcc"
set -gx CXX "g++"
set -gx EDITOR "vim"
set -gx TERMINAL "st"
set -gx BROWSER "qutebrowser"
set -gx READER "zathura"
set -gx ICAROOT "$HOME/.ica"
set -gx PATH "$HOME/.scripts:$PATH"

## accept autosuggestion
bind ^j accept-autosuggestion

## path
# lumerical fdtd
set -gx PATH "/opt/lumerical/fdtd/bin:$PATH"
# custom scripts
set -gx PATH "$HOME/.scripts:$PATH"
# custom openvpn command
set -gx PATH "$HOME/.config/openvpn:$PATH"
# custom vim command
set -gx PATH "$HOME/.config/nvim/vim:$PATH"
# custom git commands (powered by vim and tmux)
set -gx PATH "$HOME/.config/nvim/git:$PATH"

## python
# anaconda python
set -gx PATH "$HOME/.anaconda/bin:$PATH"
# to enable conda activate
source "$HOME/.anaconda/etc/fish/conf.d/conda.fish" 
# set python path from "~/.pythonpath" file
set -gx PYTHONPATH (string replace "~" $HOME (tr '\n' ':' < ~/.pythonpath | head -c -1))

## i3 [this should be placed last]
# start i3 if it is not yet running
if test (tty) = "/dev/tty1"
    pgrep -x i3; or exec startx
end
