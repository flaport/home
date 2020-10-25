# fontconfig

- Default fonts families are defined in [fonts.conf](fonts.conf).

- All other font settings reside in the [conf.d](conf.d) folder.

Many of the other settings involve blocking fonts which cannot be
uninstalled due to them being dependencies of other programs. If I
have no need for a font I usually disable it. My goal is to only have
fonts on my system which I actually want.

## font examples

In this folder, you'll find a [fonts.html](fonts.html) file which shows which fonts are
blocked and how some fonts are aliased to other fonts. Please note that this html file
is best opened in _LibreOffice_ as Firefox or Chromium only use fontconfig partly (and
hence might show different fonts than the intended ones)

## conf.d folder

#### 10-sub-pixel-rgb.conf

Improves sharpness of font rendering.

#### 11-lcdfilter-default.conf

Reduce color fringing due to subpixel rendering.

#### 67-chinese.conf

Create fallback order for chinese symbols

#### 68-icons.conf

Defines the icons font family containing the awesome-terminal fonts.
The icons font is also family configured as fallback font for the
three fontfamilies.

#### 70-block-bitmaps.conf

Bitmap fonts are ugly. They are now disabled.

#### 71-block-adobe.conf

Both _Source Code Pro_ and _Source Code Variable_ are blocked.

#### 71-block-adobe-cn.conf

Only _Source Han Serif CN_ and _Source Han Sans CN_ Remain.

#### 71-block-adobe-tw.conf

Both _Source Han Serif TW_ and _Source Han Sans TW_ are blocked.

#### 71-block-awesome.conf

No fonts are currently blocked for _Awesome Terminal Fonts_.

#### 71-block-cantarell.conf

Only _Cantarell_ with styles _Regular_ and _Bold_ remains available.

#### 71-block-dejavu.conf

_DejaVu_ has too many ugly emoji glyphs which prevent the glyphs of my
default emoji font to be displayed. Hence _DejaVu_ is - and will
always be - disabled in my fontconfig. Use _Bitstream Vera_ instead.

#### 71-block-droid.conf

Only _Droid Serif_, _Droid Sans_ and _Droid Sans Mono_ remain available.

#### 71-block-fira.conf

Only _Fira Code_ with styles _Regular_ and _Bold_ remains available.

#### 71-block-gnu-fonts.conf

All _GNU fonts_ are currently blocked.

#### 71-block-gsfonts.conf

Only _Nimbus Sans_ and _Numbus Roman_ remain available.

#### 71-block-hack.conf

Only _Hack Nerd Font_ with styles _Regular_ and _Bold_ remains available.

#### 71-block-inconsolata.conf

The monospace font _Inconsolata_ is blocked.

#### 71-block-liberation.conf

No _Liberation fonts_ are blocked.

#### 71-block-libertine.conf

Only _Linux Biolinum_ remains available.

#### 71-block-microhei.conf

All _WenQuanYi Micro Hei_ fonts are blocked. They interfere with korean fonts.

#### 71-block-ms.conf

The font collection `ttf-ms-fonts` provides a nice collection of fonts for better
compatibility with MS Office. That said, we don't need _all_ of the fonts provided by
these two packages.

#### 71-block-ubuntu.conf

The _Ubuntu Condensed_ font was blocked.

#### 71-block-vera.conf

_Bitstream Vera_ is for the most part identical to _DejaVu_, but does
not have emojis. This is a good thing! This way Vera does not interfere with my emoji
font. No fonts are currently blocked for _Bitstream Vera_.

#### 71-block-vista.conf

The font collection `ttf-vista-fonts` provides a nice collection of fonts for better
compatibility with MS Office. That said, we don't need _all_ of the fonts provided by
these two packages.

#### 72-block-emoji.conf

All common emoji fonts except the one I'm using are blocked.
