# go to home directory
cd ~

## Update Arch
echo -e "\n\n\n\n"
echo "Updating Arch Linux..."
echo -e "\n\n\n\n"
sleep 5

sudo pacman -Syu --noconfirm


## git
echo -e "\n\n\n\n"
echo "Installing git..."
echo -e "\n\n\n\n"
sleep 5

# installation
sudo pacman -S --noconfirm git
# git default email adress
git config --global user.email "floris.laporte@gmail.com"
# git default email adress
git config --global user.name flaport
# cache git password for 12 hours
git config --global credential.helper "cache --timeout=43200"


## Arch repositories
echo -e "\n\n\n\n"
echo "Installing packages from the Arch Repositories..."
echo -e "\n\n\n\n"
sleep 5

## vim
# installation
sudo pacman -S --noconfirm neovim
# aliasses
sudo ln -sf /usr/bin/nvim /usr/bin/vim

## i3: the main graphical user interface
# i3-gaps: allow gaps between windows
sudo pacman -S --noconfirm i3-gaps
# i3-blocks: status bar for i3
sudo pacman -S --noconfirm i3blocks
# i3-block: screen lock for i3
sudo pacman -S --noconfirm i3lock
# xdotool: allows for more complicated window manipulation commands
sudo pacman -S --noconfirm xdotool
# unicode characters
sudo pacman -S --noconfirm rxvt-unicode
# wallpapers
sudo pacman -S --noconfirm feh
# xterm
sudo pacman -S --noconfirm xterm
# sockets
sudo pacman -S --noconfirm socat

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

## build tools
# makefiles
sudo pacman -S --noconfirm make

## fonts
# monospace
sudo pacman -S --noconfirm ttf-inconsolata
# serif/sans-serif
sudo pacman -S --noconfirm ttf-linux-libertine
# browser font
sudo pacman -S --noconfirm ttf-ubuntu-font-family

## security
# gnupg
sudo pacman -S --noconfirm gnupg

## ranger: terminal file browser
sudo pacman -S --noconfirm ranger

## arandr: for screen adjustment
sudo pacman -S --noconfirm arandr

## drive and file system access
# dosfstools: support for dos (windows) - like filesystems
sudo pacman -S --noconfirm dosfstools
# exfat-utils: access fat-drives
sudo pacman -S --noconfirm exfat-utils
# ntfs-3g: access NTFS partitions
sudo pacman -S --noconfirm ntfs-3g

## desktop notifications
# libnotify allows desktop notifications
sudo pacman -S --noconfirm libnotify
# dunst creates desktop notifications (suckless)
sudo pacman -S --noconfirm dunst

## image viewer
sudo pacman -S --noconfirm sxiv

## wallpaper adjustment
sudo pacman -S --noconfirm xwallpaper

## image and video tools
# imagemagick: for images
sudo pacman -S --noconfirm imagemagick
# maim: screenshots
sudo pacman -S --noconfirm maim
# ffmpeg: for videos
sudo pacman -S --noconfirm ffmpeg
# youtube-dl: download youtube videos
sudo pacman -S --noconfirm youtube-dl

## network tools
sudo pacman -S --noconfirm networkmanager
sudo systemctl enable NetworkManager

## terminal
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

## archives
# atool gives information about archives
sudo pacman -S --noconfirm atool
# unrar
sudo pacman -S --noconfirm unrar
# unzip
sudo pacman -S --noconfirm unzip

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
sudo pacman -S --noconfirm nvidia

## Sound
# alsamixer
sudo pacman -S alsa-utils alsa-plugins


## browsers
# qutebrowser
sudo pacman -S --noconfirm qutebrowser
sudo pacman -S --noconfirm chromium
sudo pacman -S --noconfirm firefox

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
echo "Installing packages from the AUR..."
echo -e "\n\n\n\n"
sleep 5

## Tools
# hide an inactive mouse
yay -S --noconfirm unclutter-xfixes-git

## Terminal
# make urls selectable
yay -S --noconfirm urlscan

## drive and file system access
yay -S --noconfirm simple-mtpfs

## Fonts
yay -S --noconfirm ttf-emojione
yay -S --noconfirm ttf-symbola

echo -e "\n\n\n\n"
echo "Installing Packages from GitHub"
echo -e "\n\n\n\n"
sleep 5

# suckless terminal of Luke Smith
git clone http://github.com/lukesmithxyz/st.git
cd st
make
sudo make install
cd ..
rm -rf st

# redating git commands
git clone http://github.com/potatolabs/git-redate .git-redate

echo -e "\n\n\n\n"
echo "Installing Miniconda"
echo -e "\n\n\n\n"
sleep 5

cd ~
curl https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh --output miniconda.sh
sh miniconda.sh -b -p $HOME/.anaconda
rm miniconda.sh
