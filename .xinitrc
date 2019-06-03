#!/usr/bin/env bash

#    _____ _     ____  ____  ____  ____  _____ 
#   /    // \   /  _ \/  __\/  _ \/  __\/__ __\
#   |  __\| |   | / \||  \/|| / \||  \/|  / \  
#   | |   | |_/\| |-|||  __/| \_/||    /  | |  
#   \_/   \____/\_/ \|\_/   \____/\_/\_\  \_/  
#

set wallpaper
feh --bg-scale ~/.config/wallpaper.png & disown

# enable transparent windows
xcompmgr & disown

# update color database of xcompmgr
xrdb ~/.Xresources & disown

# export your desired screenlayout with `arandr`
~/.config/screenlayout/default & disown

# notifications
dunst & disown

# network manager applet (in most right corner of the screen)
nm-applet & disown

# automatically lock screen after 10 minutes
xautolock -time 10 -locker ~/.scripts/lock_screen & disown

# make the mouse invisible after a brief period of not using it.
unclutter & disown

# set cursor speed
xset r rate 200 45

# execute i3
# exec i3 > ~/.i3.log

# execute dwm
exec dwm

