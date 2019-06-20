#!/usr/bin/env bash

#    _____ _     ____  ____  ____  ____  _____ 
#   /    // \   /  _ \/  __\/  _ \/  __\/__ __\
#   |  __\| |   | / \||  \/|| / \||  \/|  / \  
#   | |   | |_/\| |-|||  __/| \_/||    /  | |  
#   \_/   \____/\_/ \|\_/   \____/\_/\_\  \_/  
#

# select window manager [i3 / dwm]
export WM=dwm

set wallpaper
~/.scripts/set_wallpaper ~/.config/wallpaper.png &

# enable transparent windows
xcompmgr &

# update color database of xcompmgr
if [ -f ~/.Xresources ]; then
    xrdb ~/.Xresources
fi

# export your desired screenlayout with `arandr`
~/.config/screenlayout/default &

# notifications
dunst &

# network manager applet (in most right corner of the screen)
nm-applet &

# automatically lock screen after 10 minutes
xautolock -time 10 -locker ~/.scripts/lock_screen &

# make the mouse invisible after a brief period of not using it.
unclutter &

# set cursor speed
xset r rate 200 45 &

# execute window manager
exec $WM > ~/.local/share/$WM.log

