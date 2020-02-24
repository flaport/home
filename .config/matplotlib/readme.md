# matplotlib
Matplotlib is a Python plotting library.

## stylelib
This is a special matplotlib folder. Any `.mplstyle` file in this
folder will be picked up by matplotlib and made available as follows:
```
>>> import matplotlib as mpl
>>> mpl.style.use("fivethirtyeight")
```

I also created the [mpl](../../.scripts/matplotlib/mpl) script. This
is a convenience command line utility that changes the default
matplotlib style globally. For example:

```
$ mpl fivethirtyeight
```

To return to the default matplotlib style:

```
$ mpl default
```

## personal-stylelib
This is a folder of personal matplotlib styles. They are linked into
the stylelib folder to make them available globally on the system as
well.
