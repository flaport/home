#!/usr/bin/env bash

#    _____ _     ____  ____  ____  ____  _____ 
#   /    // \   /  _ \/  __\/  _ \/  __\/__ __\
#   |  __\| |   | / \||  \/|| / \||  \/|  / \  
#   | |   | |_/\| |-|||  __/| \_/||    /  | |  
#   \_/   \____/\_/ \|\_/   \____/\_/\_\  \_/  
#

# select window manager [i3 / dwm]
export WM=dwm

# set wallpaper
wallpaper current-wallpaper &

# enable transparent windows
xcompmgr &

# update color database of xcompmgr
if [ -f ~/.Xresources ]; then
    xrdb ~/.Xresources &
fi

# start smdv (simple markdown viewer) in the background
smdv --no-browser &

# export your desired screenlayout with `arandr`
default_screenlayout &

# notifications
dunst &

# network manager applet (in most right corner of the screen)
nm-applet &

# automatically lock screen after 10 minutes
xautolock -time 10 -locker validate_and_lock_screen &

# make the mouse invisible after a brief period of not using it.
unclutter &

# set cursor speed
# wrapped into loop, as sometimes this stops working
while true; do
    xset r rate 200 45 &
    sleep 60
done &

# execute window manager
exec $WM > ~/.local/share/$WM.log

