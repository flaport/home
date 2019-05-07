# Arch Home

This is a backup of my home folder on Arch Linux. By default nothing is added
to this folder because the `.gitignore` contains a single `*`: by default it
will ignore all new files added added to the home folder. Only while explicitly
adding (with the `-f` flag) and commiting a file to the repository, it will be
tracked.

## Installation instructions

Please follow the steps outlined in the [first install readme](../.first_install/readme.md). **Please follow these steps carefully to make sure all programs are
correctly installed.**

## Folders

### [.config](../.config)

All my personal configuration files for most installed programs.

### [.extra](../.extra)

All kind of useful files and file templates that are not supposed to be stored
in the home directory (like systemd services, fstab files, ...)

### [.first_install](../.first_install)

Contains a readme file [`readme.md`](.first_install/readme.md) containing all
the manual installation steps needed to be taken to make a proper Arch Linux
installation.

It also contains an installation bash script
[`first_install.sh`](../.first_install/first_install.sh) which installs the
essential programs for the new installation automatically.

It also contains an installation bash script for user installation files
[`user_install.sh`](../.first_install/user_install.sh).

### [.github](../.github)

A folder where I can store this readme file. This way I don't have to store the
readme.md file in the root of this repository (and thus I do not have to store
it in the root of my home folder)

### [.ipython/profile_default/startup](../.ipython/profile_default/startup)

Simple files that have to be run before running ipython.

### [.jupyter](../.jupyter)

My jupyter configuration files

### [.scripts](../.scripts)

Custom scripts that are useful in the terminal

### [.ssh](../.ssh)

SSH configuration and explanation

### [.webapps](../.webapps)

Webapps (like gmail, youtube, maps, ...) are opened with chromium as an app
(without search bar).

## Files

### [.Xresources](../.Xresources)

Color settings for apps

### [.bash_logout](../.bash_logout)

Commands to run at logout

### [.bash_profile](../.bash_profile)

Commands to run at login

### [.bashrc](../.bashrc)

Commands to run when opening a new terminal

### [.gitconfig](../.gitconfig)

Git settings and configuration

### [.gitignore](../.gitignore)

Gitignore file for this repository. Is set to ignore every file by default,
except the files it is already tracking. New files can be tracked with the `-f`
flag.

### [.inputrc](../.inputrc)

Terminal settings

### [.pythonstartup](../.pythonstartup)

Commands to run at every new python session. This is enforced by the
$PYTHONSTARTUP environment variable (and the IPython startup scripts for
IPython).

### [.tmux.conf](../.tmux.conf)

Tmux configuration file

### [.xinitrc](../.xinitrc)

X-server initialization settings.
