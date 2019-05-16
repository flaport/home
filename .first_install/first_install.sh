#!/usr/bin/env bash

# ---------------------------------------------------- #
# !!! NOTE THAT THIS SCRIPT SHOULD NOT BE SOURCED. !!! #
# ---------------------------------------------------- #


# ------ #
# CHECKS #
# ------ #

## Pre-installation checks
if [ $USER == root ]; then
    echo
    echo "first_install.sh should not be run as root / with sudo."
    echo "this script should be run normally by a user [with sudo privileges]."
    exit 1
fi

if [[ "${BASH_SOURCE[0]}" != "${0}" ]]; then
    echo
    echo "first_install.sh should NOT be sourced."
    exit 1
else

# ---------- #
# USER INPUT #
# ---------- #

# Ask for password, this will be used for all the sudo calls.:
# and to change the shell later on.
read -s -p "[sudo] password for $USER: " password
echo

# ------ #
# UPDATE #
# ------ #

## Update arch
printf "Updating Arch Linux..."
echo $password | sudo -S pacman -Syu --noconfirm &> /dev/null


# -------------------------- #
# INSTALL/CONFIGURE PACKAGES #
# -------------------------- #

## Package/Program Installation function
install() {
    # this function takes exactly one argument: the package to install
    # it automatically chooses pacman or yay, depending if pacman fails or not.
    # it ignores packages that are already installed.
    if [ $2 ]; then
        echo "too many arguments";
    elif [ ! $1 ]; then
        echo "too few arguments";
    else
        printf "installing $1... "
        echo $password | sudo -S pacman -Q $1 &> /dev/null;
        if [ $? -ne 0 ]; then
            # if package does not exist, try to install it with pacman
            echo $password | sudo -S pacman -S --noconfirm --noprogress $1 &> /dev/null
            if [ $? -ne 0 ]; then
                # if installing with pacman fails, try to install it with yay
                yay -S -q --noconfirm $1 &> /dev/null
                if [ $? -ne 0 ]; then
                    # if installing with yay fails, try to install it with git
                    git clone $1 /tmp/gitpkg
                    cd /tmp/gitpkg
                    makepkg -si --noconfirm --noprogress &> /dev/null
                    if [ $? -ne 0 ]; then
                        # if installing with git fails, we give up
                        echo failed
                    else
                        echo installed
                    fi
                    # clean up
                    cd ~
                    rm -rf /tmp/gitpkg
                fi
            else
                echo installed
            fi
        else
            echo already installed.
        fi
    fi
}

## Security
install gnupg # gpg --full-gen-key (generate gpg key)
install pass # pass init floris.laporte@gmail.com (use gpg key to store passwords securely)

## Source control
install git
install mercurial

## build tools
install make

## AUR package manager
install https://aur.archlinux.org/yay.git

## Terminal
## suckless terminal (Luke Smith fork)
install st-luke-git
# vim / neovim
install neovim
echo $password | sudo -S ln -sf /usr/bin/nvim /usr/bin/vim
# rsync: safe and secure copy & backup
install rsync
# atool gives information about archives
install atool
# unrar
install unrar
# unzip
install unzip
# rpm extraction shell script
install rpmextract
# pv: progress bars on stdout
install pv
# battery information
install acpi
# vifm: terminal file browser
install vifm
# terminal internet search: google
install googler
# terminal internet search: duckduckgo
install ddgr
# search tool (grep alternative, necessary for some vim extensions)
install ack
# fuzzy finder tool
install fzf
# multiple terminals in one
install tmux
# copying and pasting from the terminal
install xclip
# pdf previews
install poppler
# highlight: to highlight code
install highlight
# mediainfo: show audio and video information in terminal
install mediainfo
# process information
install htop
# terminal spreadsheets
install sc-im

## Graphical server: xorg
# the graphical server
install xorg-server
# querying window information
install xorg-xwininfo
# initializing
install xorg-xinit
# tool for detecting window properties
install xorg-xprop
# for transparent windows etc.
install xcompmgr
# for changing brightnes etc:
install xorg-xbacklight
# get info on current active windows
install xorg-xdpyinfo
# hide an inactive mouse
install unclutter-xfixes-git

## Desktop Environment / Window Manager
# i3-gaps: allow gaps between windows
install i3-gaps
# i3-blocks: status bar for i3
install i3blocks
# i3-lock: screen lock for i3
install i3lock-fancy-git
# xautolock to automatically lock the screen
install xautolock
# wallpapers
install feh
# sockets
install socat
# dmenu
install dmenu
# theme:  Arc
install arc-solid-gtk-theme

## Printers
# printer system (cups @ localhost:631)
install cups
# for network printing
install avahi
install nss-mdns
echo $password | sudo -S systemctl enable avahi-daemon
install samba
# print to pdf
install cups-pdf
# enable cups service
echo $password | sudo -S systemctl enable org.cups.cupsd

## fonts
# monospace
install ttf-inconsolata
# serif
install ttf-linux-libertine
# sans-serif + chromium/firefox dependency
install ttf-droid
# symbols
install ttf-symbola
# disable bitmaps:
echo $password | sudo -S ln -sf /etc/fonts/conf.avail/70-no-bitmaps.conf /etc/fonts/conf.d
# enable sub-pixel RGB rendering
echo $password | sudo -S ln -sf /etc/fonts/conf.avail/10-sub-pixel-rgb.conf /etc/fonts/conf.d
# enable LCD-filtering
echo $password | sudo -S ln -sf /etc/fonts/conf.avail/11-lcdfilter-default.conf /etc/fonts/conf.d

## GUIs
# nemo: sometimes a non-terminal file browser can be useful
install nemo
# screen settings: arandr (& xrandr)
install arandr
# general document reader with vim bindings
install zathura
# pdf reader extension
install zathura-pdf-mupdf
# djvu reader extension
install zathura-djvu

## Artistic
install gimp
install pinta
install inkscape
# install krita

## Office
# open-source office
install libreoffice
# sqlite database browser
install sqlitebrowser

## Programming
# code OSS (open source build of vscode)
install code
code --install-extension vscodevim.vim
code --install-extension ban.spellright
code --install-extension wholroyd.jinja
code --install-extension ms-python.python
code --install-extension codezombiech.gitignore
code --install-extension james-yu.latex-workshop
code --install-extension formulahendry.code-runner
code --install-extension shardulm94.trailing-spaces
code --install-extension robertohuertasm.vscode-icons
code --install-extension richie5um2.vscode-sort-json
code --install-extension pkief.material-icon-theme

## Drive and file system access
# mount cifs parititions
install cifs-utils
# dosfstools: support for dos (windows) - like filesystems
install dosfstools
# exfat-utils: access fat-drives
install exfat-utils
# ntfs-3g: access NTFS network drives
install ntfs-3g
# acces media on external device (phone, ...)
install simple-mtpfs
# install scripts for bootstrapping new arch installation
install arch-install-scripts

## Desktop notifications
# libnotify allows desktop notifications
install libnotify
# dunst creates desktop notifications
install dunst

## image and video tools
# image viewer
install sxiv
# imagemagick: for images
install imagemagick
# youtube-dl: download youtube videos
install youtube-dl
# youtube-viewer
install youtube-viewer
# vlc media player
install vlc
# mpv media player
install mpv
# ffmpeg command line tool
install ffmpeg
# spotify
install spotify

## Connectivity & network tools
# network manager
install networkmanager
echo $password | sudo -S systemctl enable NetworkManager
# applet in the corner of the screen
install network-manager-applet
# openvpn
install openvpn
# ssh (client and server)
install openssh
# autossh (for ssh daemons)
install autossh
# whois information
install whois
# access to google servers
install google-cloud-sdk
# bluetooth
install bluez
install bluez-utils
install pulseaudio-bluetooth
echo $password | sudo -S systemctl enable bluetooth
# remote desktop
install remmina
install freerdp

## Sound
# alsamixer
install alsa-utils
install alsa-plugins
install pulseaudio

## Latex
# tex-live
# install texlive-most
# bibliographies
install biber
# viewer with synctex support
install xdotool

## Browsers
# install surf
# install firefox
install chromium
install qutebrowser

## Email
# send email
install msmtp
# sync email
install isync
# mutt email client
install neomutt
echo $password | sudo -S ln -sf /usr/bin/neomutt /usr/bin/mutt
# html email view (also browser!)
install w3m
# mutt wizard
install mutt-wizard

## Power & sleep
# sleep on low power
install acpid
echo $password | sudo -S systemctl enable acpid
echo $password | sudo -S chmod a+w /sys/power/state

## graphics card:
# this is disabled by default, as it gives troubles on devices without nvidia gpu
# nvidia driver
# install nvidia
# install cuda-toolkit

## GDS Layouts
# Klayout (takes very long, hence disabled by default)
# install klayout

## install programs for the user (disabled by default as this is up to the user):
# source ~/.first_install/user_install.sh

# ------ #
# PYTHON #
# ------ #

# create files where the system depends upon (check .bashrc and config.fish)
touch $HOME/.pythonpath # defines the $PYTHONPATH environment variable
touch $HOME/.pythonstartup # defines the $PYTHONSTARTUP environment variable

# system python packages
install tk
install python-pip
install python2-pip
install python-tqdm
install python2-tqdm
install python-numpy
install python2-numpy
install python-matplotlib
install python2-matplotlib
# Scientific computing octave (matlab alternative)
install octave
# install neovim integration for system python
echo $password | sudo -S python2 -m pip install neovim
echo $password | sudo -S python3 -m pip install neovim
echo $password | sudo -S python3 -m pip install neovim-remote
# image previews in vifm/ranger
echo $password | sudo -S python3 -m pip install ueberzug
# document portability
echo $password | sudo -S python3 -m pip install pandoc
echo $password | sudo -S python2 -m pip install pandoc
echo $password | sudo -S python2 -m pip install google-api-python-client google-auth-httplib2 google-auth-oauthlib
echo $password | sudo -S python3 -m pip install google-api-python-client google-auth-httplib2 google-auth-oauthlib


# -------- #
# Services #
# -------- #
echo $password | sudo -S $HOME/.first_install/services # TODO: merge the services file with this one.
echo $password | sudo -S systemctl daemon-reload
echo $password | sudo -S systemctl enable jupyterhub.service


# --------------- #
# System settings #
# --------------- #

# set correct date/time
echo $password | sudo -S timedatectl set-local-rtc 1


# ----------------- #
# Alternative Shell #
# ----------------- #

# alternative shell
install fish
echo $password | chsh -s /usr/bin/fish

#-------------------------------------
fi # stop if to check for source (an exit 1 would have closed the terminal).
