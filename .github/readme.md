# Arch Home

a.k.a my dotfiles.


## How does this work?

By default nothing is added to this folder because the `.gitignore` contains a
single `*`: by default it will ignore all new files added added to the home
folder. Only while explicitly adding (with the `-f` flag) and commiting a file
to the repository, it will be tracked.

## Installation instructions:

Initialize an empty home folder as a git repository (complete instructions
[here](../.install/readme.md)):
```
git init .
```
add this git repository (or your fork) as origin:
```
git remote add origin http://github.com/flaport/arch_home
```
pull the repository:
```
git pull origin master
```
set up the master branch to track the master brach at origin
```
git branch --set-upstream-to=origin/master master
```
pull in all git submodules for custom builds
```
git submodule update --init --recursive
```
install programs (please edit the file to your liking first):
```
bash ~/.install/arch_install
```
[optional] create anaconda environment:
```
bash ~/.install/python_install
```

## Other relevant stuff:
* [My st fork](https://github.com/flaport/st)
* [My dwm fork](https://github.com/flaport/dwm)
* [My dmenu fork](https://github.com/flaport/dmenu)

## License
© flaport 2020 - GPLv3

