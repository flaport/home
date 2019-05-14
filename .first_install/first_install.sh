# go to home directory
cd ~

# updating time and date
sudo timedatectl set-local-rtc 1

echo -e "\n\n\n\n"
echo "Changing shell to fish..."
echo -e "\n\n\n\n"
sleep 1

## better bash
sudo pacman -S --noconfirm fish
chsh -s /usr/bin/fish

## Update Arch
echo -e "\n\n\n\n"
echo "Updating Arch Linux..."
echo -e "\n\n\n\n"
sleep 1

sudo pacman -Syu --noconfirm

## git
echo -e "\n\n\n\n"
echo "Installing source control..."
echo -e "\n\n\n\n"
sleep 5

# installation
sudo pacman -S --noconfirm git
sudo pacman -S --noconfirm mercurial

echo -e "\n\n\n\n"
echo "Installing YAY..."
echo -e "\n\n\n\n"
sleep 5
cd ~
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm
cd ~
rm -rf yay

echo -e "\n\n\n\n"
echo "Installing other packages..."
echo -e "\n\n\n\n"
sleep 5

## vim
# installation
sudo pacman -S --noconfirm neovim
sudo ln -sf /usr/bin/nvim /usr/bin/vim

## Code OSS (vscode comunity edition)
sudo pacman -S --noconfirm code

## build tools
# makefiles
sudo pacman -S --noconfirm make

## suckless terminal (Luke Smith fork)
yay -S --noconfirm st-luke-git

## i3: the main graphical user interface
# i3-gaps: allow gaps between windows
sudo pacman -S --noconfirm i3-gaps
# i3-blocks: status bar for i3
sudo pacman -S --noconfirm i3blocks
# i3-lock: screen lock for i3
yay -S --noconfirm i3lock-fancy-git
# xautolock to automatically lock the screen
sudo pacman -S --noconfirm xautolock
# wallpapers
sudo pacman -S --noconfirm feh
# sockets
sudo pacman -S --noconfirm socat
# dmenu
sudo pacman -S --noconfirm dmenu
# pywal (automatic theming on background colors)
sudo pacman -S --noconfirm python-pywal

## xorg: the graphical server
# the graphical server
sudo pacman -S --noconfirm xorg-server
# querying window information
sudo pacman -S --noconfirm xorg-xwininfo
# initializing
sudo pacman -S --noconfirm xorg-xinit
# tool for detecting window properties
sudo pacman -S --noconfirm xorg-xprop
# for transparent windows etc.
sudo pacman -S --noconfirm xcompmgr
# for changing brightnes etc:
sudo pacman -S --noconfirm xorg-xbacklight
# get info on current active windows
sudo pacman -S --noconfirm xorg-xdpyinfo
# hide an inactive mouse
yay -S --noconfirm unclutter-xfixes-git

## archiving tools
# rsync
sudo pacman -S --noconfirm rsync
# atool gives information about archives
sudo pacman -S --noconfirm atool
# unrar
sudo pacman -S --noconfirm unrar
# unzip
sudo pacman -S --noconfirm unzip
# rpm extraction shell script
yay -S --noconfirm rpmextract
# pv: progress bars on stdout
sudo pacman -S --noconfirm pv

## printers
# printer system (cups @ localhost:631)
sudo pacman -S --noconfirm cups
sudo echo -n "Allow all" >> /etc/cups/cupsd.conf
sudo systemctl enable org.cups.cupsd
# print to pdf
sudo pacman -S --noconfirm cups-pdf
# for network printing
sudo pacman -S --noconfirm avahi
sudo pacman -S --noconfirm nss-mdns
sudo systemctl enable avahi-daemon
sudo pacman -S --noconfirm samba

## toolbar
# battery information
sudo pacman -S --noconfirm acpi

## fonts
# monospace
sudo pacman -S --noconfirm ttf-inconsolata
# serif
sudo pacman -S --noconfirm ttf-linux-libertine
# sans-serif + chromium/firefox dependency
sudo pacman -S --noconfirm ttf-droid
# symbols
yay -S --noconfirm ttf-symbola
# disable bitmaps:
sudo ln -s /etc/fonts/conf.avail/70-no-bitmaps.conf /etc/fonts/conf.d
# enable sub-pixel RGB rendering
sudo ln -s /etc/fonts/conf.avail/10-sub-pixel-rgb.conf /etc/fonts/conf.d
# enable LCD-filtering
sudo ln -s /etc/fonts/conf.avail/11-lcdfilter-default.conf /etc/fonts/conf.d
# enable freetype subpixel hinting:
echo 'export FREETYPE_PROPERTIES="truetype:interpreter-version=40"' | sudo tee --append /etc/profile.d/freetype2.sh

## Connectivity
# openvpn
sudo pacman -S --noconfirm openvpn
# ssh (client and server)
sudo pacman -S --noconfirm openssh
# autossh (for ssh daemons)
sudo pacman -S --noconfirm autossh

## Theme
# Arc
sudo pacman -S --noconfirm arc-solid-gtk-theme

## file browsers
# vifm: terminal file browser
sudo pacman -S --noconfirm vifm
# alternative: ranger: terminal file browser
# sudo pacman -S --noconfirm ranger
# image previews in terminal
# sudo pacman -S --noconfirm w3m

## GUI file browser
# nemo: sometimes a non-terminal file browser can be useful
sudo pacman -S --noconfirm nemo
# alternative: dolphin: alternative to nemo (I prefer nemo)
# note: the environment variable QT_QPA_PLATFORMTHEME='qt5ct' should be set.
# sudo pacman -S --noconfirm dolphin
# sudo pacman -S --noconfirm qt5ct
# sudo pacman -S --noconfirm dolphin-plugins
# sudo pacman -S --noconfirm konsole
# sudo pacman -S --noconfirm kompare

## terminal internet search
# google
yay -S --noconfirm googler
# duckduckgo
yay -S --noconfirm ddgr

## arandr: for screen adjustment
sudo pacman -S --noconfirm xrandr
sudo pacman -S --noconfirm arandr

## drive and file system access
# mount cifs parititions
sudo pacman -S --noconfirm cifs-utils
# dosfstools: support for dos (windows) - like filesystems
sudo pacman -S --noconfirm dosfstools
# exfat-utils: access fat-drives
sudo pacman -S --noconfirm exfat-utils
# ntfs-3g: access NTFS network drives
sudo pacman -S --noconfirm ntfs-3g
# acces media on external device (phone, ...)
yay -S --noconfirm simple-mtpfs
# install scripts for bootstrapping new arch installation
sudo pacman -S --noconfirm arch-install-scripts

## desktop notifications
# libnotify allows desktop notifications
sudo pacman -S --noconfirm libnotify
# dunst creates desktop notifications (suckless)
sudo pacman -S --noconfirm dunst

## image and video tools
## image viewer
sudo pacman -S --noconfirm sxiv
# imagemagick: for images
sudo pacman -S --noconfirm imagemagick
# youtube-dl: download youtube videos
sudo pacman -S --noconfirm youtube-dl
# youtube-viewer
sudo pacman -S --noconfirm youtube-viewer
# vlc media player
sudo pacman -S --noconfirm vlc
# mpv media player
sudo pacman -S --noconfirm mpv
# ffmpeg command line tool
sudo pacman -S --noconfirm ffmpeg
# spotify
yay -S --noconfirm spotify

## network tools
sudo pacman -S --noconfirm networkmanager
sudo systemctl enable NetworkManager
sudo pacman -S --noconfirm network-manager-applet
sudo pacman -S --noconfirm whois
yay -S --noconfirm google-cloud-sdk

## bluetooth
sudo pacman -S --noconfirm bluez
sudo pacman -S --noconfirm bluez-utils
sudo pacman -S --noconfirm pulseaudio-bluetooth
sudo systemctl enable bluetooth

## terminal
# search tool (grep alternative, necessary for some vim extensions)
sudo pacman -S --noconfirm ack
# fuzzy finder tool
sudo pacman -S --noconfirm fzf
# multiple terminals in one
sudo pacman -S --noconfirm tmux
# copying and pasting from the terminal
sudo pacman -S --noconfirm xclip
# pdf previews
sudo pacman -S --noconfirm poppler
# highlight: to highlight code
sudo pacman -S --noconfirm highlight
# mediainfo: show audio and video information in terminal
sudo pacman -S --noconfirm mediainfo

## process information
sudo pacman -S --noconfirm htop

## keboard shortcuts
# xcape: used for example to remap caps lock to esc
sudo pacman -S --noconfirm xcape

## readers
# general document reader with vim bindings
sudo pacman -S --noconfirm zathura
# pdf reader extension
sudo pacman -S --noconfirm zathura-pdf-mupdf
# djvu reader extension
sudo pacman -S --noconfirm zathura-djvu

## graphics card:
# nvidia: nvidia driver
# this is disabled by default, as it gives troubles on devices without nvidia gpu
# sudo pacman -S --noconfirm nvidia
# suda pacman -S --noconfirm cuda-toolkit

## Sound
# alsamixer
sudo pacman -S --noconfirm alsa-utils
sudo pacman -S --noconfirm alsa-plugins
sudo pacman -S --noconfirm pulseaudio

## Latex
# tex-live
sudo pacman -S --noconfirm texlive-most
sudo pacman -S --noconfirm texlive-lang
# bibliographies
sudo pacman -S --noconfirm biber
# viewer with synctex support
sudo pacman -S --noconfirm xdotool

## browsers
# sudo pacman -S --noconfirm surf
# sudo pacman -S --noconfirm firefox
sudo pacman -S --noconfirm chromium
sudo pacman -S --noconfirm qutebrowser

## Artistic
sudo pacman -S --noconfirm gimp
# sudo pacman -S --noconfirm krita
# sudo pacman -S --noconfirm pinta
yay -S --noconfirm inkscape

## Remote desktop
sudo pacman -S --noconfirm remmina
sudo pacman -S --noconfirm freerdp

## Office
# terminal spreadsheets
yay -S --noconfirm sc-im
# open-source office
sudo pacman -S --noconfirm libreoffice
# sqlite database browser
sudo pacman -S --noconfirm sqlitebrowser

## Programming
# code (open source build of vscode)
sudo pacman -S --noconfirm code
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

## Power & sleep
# sleep on low power
sudo pacman -S --noconfirm acpid
sudo systemctl enable acpid
chmod a+w /sys/power/state

## GDS Layouts
# Klayout (takes very long, hence disabled by default)
# yay -S --noconfirm klayout

## Scientific computing octave (matlab alternative)
sudo pacman -S --noconfirm octave

echo -e "\n\n\n\n"
echo "Python packages"
echo -e "\n\n\n\n"
sleep 5

# system python packages
sudo pacman -S --noconfirm tk
sudo pacman -S --noconfirm python-pip
sudo pacman -S --noconfirm python2-pip
sudo pacman -S --noconfirm python-tqdm
sudo pacman -S --noconfirm python2-tqdm

# install neovim integration for system python
sudo python2 -m pip install neovim
sudo python3 -m pip install neovim
sudo python3 -m pip install neovim-remote

# image previews in vifm/ranger
sudo python3 -m pip install ueberzug

# document portability
sudo python3 -m pip install pandoc
sudo python2 -m pip install pandoc
sudo python2 -m pip install google-api-python-client google-auth-httplib2 google-auth-oauthlib
sudo python3 -m pip install google-api-python-client google-auth-httplib2 google-auth-oauthlib

## install programs for the user (disabled by default as this is up to the user):
# source ~/.first_install/user_install.sh

## add new python to path
source ~/.bashrc

## Install services
sudo $HOME/.first_install/services
sudo systemctl daemon-reload
sudo systemctl enable jupyterhub.service
