#!/usr/bin/env bash
#    _____ _     ____  ____  ____  ____  _____
#   /    // \   /  _ \/  __\/  _ \/  __\/__ __\
#   |  __\| |   | / \||  \/|| / \||  \/|  / \
#   | |   | |_/\| |-|||  __/| \_/||    /  | |
#   \_/   \____/\_/ \|\_/   \____/\_/\_\  \_/


enable_hotkeys() {
    sxhkd -c ~/.config/sxhkd/sxhkdrcdwm
}
enable_hotkeys &


while true; do
    dwm_status
    sleep 10s
done &


update_weather(){
    curl -s wttr.in > ~/.cache/weatherreport
    printf "%s" "$(sed '16q;d' ~/.cache/weatherreport | grep -wo "[0-9]*%" | sort -n | sed -e '$!d' | sed -e "s/^/☔ /g" | tr -d '\n')" > ~/.cache/weatherreportshort
    sed '13q;d' ~/.cache/weatherreport | grep -o "m\\(-\\)*[0-9]\\+" | sort -n -t 'm' -k 2n | sed -e 1b -e '$!d' | tr '\n|m' ' ' | awk '{print " ❄️",$1 "°","🌞",$2 "°"}' >> ~/.cache/weatherreportshort
}
while true; do
    update_weather
    sleep 3600s
done &
