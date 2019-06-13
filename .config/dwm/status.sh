#!/usr/bin/env bash
#    _____ _     ____  ____  ____  ____  _____
#   /    // \   /  _ \/  __\/  _ \/  __\/__ __\
#   |  __\| |   | / \||  \/|| / \||  \/|  / \
#   | |   | |_/\| |-|||  __/| \_/||    /  | |
#   \_/   \____/\_/ \|\_/   \____/\_/\_\  \_/

dte(){
    date +' %Y-%m-%d | 🕒 %H:%M |'
}

mem(){
    mem=`free | awk '/Mem/ {printf "%d MiB/%d MiB\n", $3 / 1024.0, $2 / 1024.0 }'`
    echo -e " 💾 $mem |"
}

bat(){
    string=$(acpi -b 2> /dev/null)
    if [[ $string == *"Battery"* ]]; then
        if [[ $string == *"Discharging"* ]]; then
            percentage=$(echo $string | cut -d "," -f2 | cut -d "," -f1)
            echo -e " 🔋"$percentage" |"
            return;
        fi
        echo -e " 🔌 |"
        return;
    fi
    echo -e ""
}

vol(){
    sc=$($HOME/.scripts/soundcard)
    string=$(amixer -c $sc get Master)
    if [[ $string == *"[on]"* ]]; then
        percentage=$(echo $(amixer -c $sc get Master) | cut -d "[" -f2 | cut -d "]" -f1)
        echo -e " 🔊 $percentage |"
    else
      echo -e " 🔇 |"
    fi
}

wtr(){
    s=$(cat ~/.weatherreportshort)
    if [ -n "$s" ]; then
        echo -e " $s |"
    else
        echo -e ""
    fi
}

hub(){
    if [ -f /etc/systemd/system/jupyterhub.service ]; then
        if [[ $(systemctl is-active jupyterhub) == "active" ]]; then
            echo -e " 🪐 |";
            return;
        fi
    fi
    echo -e ""
}

ssh(){
    if [ -f /etc/systemd/system/sshtunnel.service ]; then
        if [[ $(systemctl is-active sshtunnel) == "active" ]]; then
            echo -e " 🔗 |";
            return;
        fi
    fi
    echo -e ""
}

vpn(){
    if [ -f /etc/systemd/system/openvpn.service ]; then
        if [[ $(systemctl is-active openvpn) == "active" ]]; then
            echo -e " 🔒 |";
            return;
        fi
    fi
    echo -e ""
}

sshd(){
    if [ -f /usr/lib/systemd/system/sshd.service ]; then
        if [[ $(systemctl is-active sshd) == "active" ]]; then
            echo -e " ⛓️ |";
            return;
        fi
    fi
    echo -e ""
}

cpu(){
  read cpu a b c previdle rest < /proc/stat
  prevtotal=$((a+b+c+previdle))
  sleep 0.5
  read cpu a b c idle rest < /proc/stat
  total=$((a+b+c+idle))
  cpu=$((100*( (total-prevtotal) - (idle-previdle) ) / (total-prevtotal) ))
  echo -e " 💻 $cpu% cpu |"
}


xsetroot -name "$(vpn)$(hub)$(ssh)$(sshd)$(bat)$(vol)$(wtr)$(dte)"
