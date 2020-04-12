# Arch Home

a.k.a my dotfiles.

*highly opinionated configurations for anything I ever used.*

#### arch + dwm + many customizations
![arch + dwm](dwm.gif)

##### what you're seeing
* [My dwm fork](https://github.com/flaport/dwm) with clickable status bar.
* [My st fork](https://github.com/flaport/st) with
[emoji support](https://gitlab.freedesktop.org/xorg/lib/libxft/-/merge_requests/1)
and support for [pywal](https://github.com/dylanaraps/pywal)
colorscheme updates (also for already open windows).
* [Neovim](https://github.com/neovim/neovim)
* [ViFM](https://github.com/vifm/vifm) + [ueberzug](https://github.com/seebye/ueberzug) image previews
* [lsd](https://github.com/Peltoche/lsd) aliased as ls
* [cli-visualizer](https://github.com/dpayne/cli-visualizer) for audio visualization.
* [Distrotube wallpapers](https://gitlab.com/dwt1/wallpapers)
* [Conky](https://github.com/brndnmtthws/conky) system monitor.
* [Picom](https://github.com/yshui/picom) compositor for window transparency, shadows and blur.
* [Spaceship](https://github.com/denysdovhan/spaceship-prompt) zsh theme


## How does this work?
My home folder *is* my dotfiles git repo.  However, by default no new
files will be tracked because the [.gitignore](../.gitignore) file
contains a single `*`. To start tracking a file, simply `git add` them
with the `-f` flag:

```
    git add -f new-file-to-track
```

## Installation instructions
Instructions on how to install Arch Linux from scratch can be found
[here](../.install/readme.md).

To try out these configs, it's best to start from a completely empty
home folder. Then initialize the home folder as a git repository:

```
git init .
```

add this git repository (or your fork) as origin:

```
git remote add origin http://github.com/flaport/arch-home
```

pull the repository:

```
git pull origin master
```

set up the master branch to track the master branch at origin

```
git branch --set-upstream-to=origin/master master
```

pull in all git submodules for custom builds

```
git submodule update --init --recursive
```

[optional but recommended] install my recommended programs with
`~/.install/arch_install`. Installing these will make sure my configs
and scripts work properly. This script won't re-install programs that
are already on the system and hence is pretty fast after its first
run. Edit the file to your liking first.

```
bash ~/.install/arch_install
```

[completely optional] I'm using python a lot. I have a similar script
with my preferred Anaconda installation. Edit the file to your liking
first.

```
bash ~/.install/python_install
```



## List of configs

A non-exhaustive list of configurations this repository has to offer:

* [app defaults](../.config/mimeapps.list/)
* [app files](../.local/share/applications/)
* [autojump](../.scripts/autojump/) · jump to folders in the cli.
* [bash](../.bashrc) · shell
* [broot](../.config/broot/) · terminal file browser
* [cat](../.scripts/cat/) · concatenate files
* [conda](../.condarc) · python package manager
* [conky](../.config/conky/) · system monitor
* [dmenu](https://github.com/flaport/dmenu) · application launcher ([rofi](../.config/rofi) alternative) + [much more](../.scripts/dmenu)
* [dunst](../.config/dunst/) · notifications
* [emacs](../.emacs.d/) · editor and more
* [fireshot](../.config/Dharkael/) · screenshots
* [fish](../.config/fish/) · shell
* [fontconfig](../.config/fontconfig) · default fonts and others
* [git](../.gitconfig) · source control + many convenience [scripts](../.scripts/git/)
* [gtk 2.0](../.config/gtk-2.0/) · gtk theming
* [gtk 3.0](../.config/gtk-3.0/) · gtk theming
* [ipython](../.ipython/profile_default/) · interactive python shell
* [joplin](../.config/joplin/) · note taking app + some basic [scripts](../.scripts/joplin/)
* [jupyter](../.jupyter/) · notebook server for python (and others)
* [kvantum](../.config/Kvantum/) · qt theming
* [latexmk](../.latexmkrc) · latex build settings
* [matplotlib](../.config/matplotlib/) · python plotting + [scripts](../.scripts/matplotlib)
* [mouse cursor](../.icons/default/index.theme) · configuration
* [mpv](../.config/mpv/) · media player
* [nemo](../.local/share/nemo/actions/) · file browser
* [neofetch](../.config/neofetch/) · system information
* [nextcloud](../.config/nextcloud/) · nextcloud client
* [nvim](../.config/nvim/) · terminal text editor
* [openvpn](../.config/openvpn/) · vpn tool
* [picom](../.config/picom/) · compositor + [alpha script](../.scripts/x/alpha) to change transparency from cli.
* [qt5ct](../.config/qt5ct/) · qt theming
* [qutebrowser](../.config/qutebrowser/) · qt based web browser with vim keybindings
* [rofi](../.config/rofi/) · application launcher ([dmenu](https://github.com/flaport/dmenu) alternative) + [much more](../.scripts/dmenu)
* [sxhkd](../.config/sxhkd/) · keyboard shortcuts
* [tmux](../.tmux.conf) · terminal multiplexer
* [vifm](../.config/vifm/) · terminal file browser with vim keybindings
* [vimb](../.config/vimb/) · web browser with vim keybindings (does not seem to work very well for me)
* [vimfx](../.config/vimfx/) · vim keybindings for firefox (requires [legacyfox patch](https://github.com/girst/LegacyFox))
* [vis](../.config/vis/) · music cli visualizer
* [vscode](../.config/Code%20-%20OSS/) · code editor
* [wallpaper](../.scripts/wallpaper/) · scripts to set wallpaper
* [xinit](../.xinitrc) · x session starter
* [xrandr](../.scripts/screenlayout/) · screenlayout [convenience scripts](../.scripts/screenlayout/) + [screenlayout selector](../.scripts/dmenu/dmenu_screenlayout).
* [xresources](../.config/Xresources) · colorschemes + [xcs script](../.scripts/x/xcs)
* [zathura](../.config/zathura/) · pdf reader + [scripts](../.scripts/zathura)
* [zsh](../.zshrc) · my preferred shell

## List of custom builds

Furthermore, this repository contains submodules for the following builds:

* [My dwm fork](https://github.com/flaport/dwm) my window manager + [scripts](../.scripts/dwm)
* [My st fork](https://github.com/flaport/st) my terminal
* [My dmenu fork](https://github.com/flaport/dmenu) my application launcher ([and much more](../.scripts/dmenu))


## License
© flaport 2020 - [GPLv3](LICENSE)

