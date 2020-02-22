# Xresources

In this folder several `.Xresources` profiles are defined. A default profile
can be chosen by linking `~/.Xresources` to one of the profiles in this folder,
followed with updating the xrdb database.

For example:
```
ln -sf ~/.config/Xresources/solarizedlight ~/.Xresources
xrdb ~/.Xresources
```

For convenience, there is a [wrapper script](../../.scripts/x/xcs) doing just
this named `xcs` (for x color scheme):

```
xcs solarizedlight
```

This wrapper script also applies the selected colorscheme to already-open
terminal windows.
