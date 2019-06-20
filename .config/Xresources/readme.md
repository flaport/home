# Xresources folder

In this folder several `.Xresources` files are defined. A default profile can be chosen
by linking `~/.Xresources` to one of the profiles in this folder, followed with updating
the xrdb database.

For example:
```
ln -sf ~/.config/Xresources/solarizedlight ~/.Xresources
xrdb ~/.Xresources
```

For convenience, there is a wrapper script doing just this named `xcs` (for x color scheme):
```
xcs solarizedlight
```

Note that the new color scheme only applies to newly spawned windows.
