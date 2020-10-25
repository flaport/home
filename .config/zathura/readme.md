# zathura

zathura is without a doubt the best pdf reader around.
A few configuration options were added to make zathura navigation act more vim-like.

## Dark color scheme
By pressing `i`, the zathurad dark colorscheme is applied. This dark
colorscheme is changed by the [xcs](../../.scripts/x/xcs) script when a new
Xresources-based colorscheme is chosen.

## Latex synctex
zathura supports synctex in both directions (tex->pdf and pdf->tex). To make it
work with neovim, however, a package called
[neovim-remote](https://github.com/mhinz/neovim-remote) needs to be installed.

