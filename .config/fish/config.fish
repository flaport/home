## fish greeting (suppressed)
function fish_greeting
end

# turn on vim mode (enable default mode first to circumvent unmapped "btab" error)
fish_default_key_bindings
fish_vi_key_bindings

## environment variables
set -gx CC "gcc"
set -gx CXX "g++"
set -gx EDITOR "vim"
set -gx TERMINAL "st"
set -gx BROWSER "qutebrowser"
set -gx READER "zathura"
set -gx ICAROOT "$HOME/.ica"
set -gx GTK2_RC_FILES "/usr/share/themes/Arc-solid/gtk-2.0/gtkrc"
# set -gx QT_QPA_PLATFORMTHEME="qt5ct"

## path
# web apps
set -gx PATH "$HOME/.webapps:$PATH"
# custom scripts
set -gx PATH "$HOME/.scripts:$PATH"
# custom vifm commands
set -gx PATH "$HOME/.config/vifm/scripts:$PATH"
# i3 commands
set -gx PATH "$HOME/.config/i3:$PATH"
# anaconda python
set -gx PATH "$HOME/.anaconda/bin:$PATH"

## python
# to enable conda activate
source "$HOME/.anaconda/etc/fish/conf.d/conda.fish" 
# set python path from "~/.pythonpath" file
touch $HOME/.pythonpath # create pythonpath file if it does not exist
set -gx PYTHONPATH (string replace "~" $HOME (tr '\n' ':' < ~/.pythonpath | head -c -1))
# set python startup file
# touch $HOME/.pythonstartup # do not touch .pythonstartup as it is part of source control
set -gx PYTHONSTARTUP "$HOME/.pythonstartup"

## accept autosuggestion
bind \ea accept-autosuggestion

## i3 [this should be placed last]
# start i3 if it is not yet running
if test (tty) = "/dev/tty1"
    while not test (pgrep -x i3)
        sleep 3
        exec startx -- vt1 > /dev/null 2>&1
    end
end
