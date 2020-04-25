# gtk-2.0

gtk 2.0 settings.

* can be configured by editing [`gtkrc`](gtkrc)
* OR can be configured with my [`xcs`](../../.scripts/x/xcs) script (recommended)
* OR can be configured with `lxappearance`.

## Note
Settings in `~/.config/xsettingsd/xsettingsd.conf` (not in source
control) have precedence over [`gtkrc`](gtkrc)!

## Note2
[`gtkrc`](gtkrc) is merely a symlink to
[`~/.gtkrc-2.0`](../../.gtkrc-2.0), the default location of GTK 2
settings. I chose to not set `GTK2_RC_FILES` to the [`gtkrc`](gtkrc)
in this folder in [`~/.profile`](../../.profile) because some programs
seem to ignore it.

