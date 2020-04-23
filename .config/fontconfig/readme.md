# fontconfig

* Default fonts families are defined in [fonts.conf](fonts.conf).

* All other font settings reside in the [conf.d](conf.d) folder.

Many of the other settings involve blocking fonts which cannot be
uninstalled due to them being dependencies of other programs. If I
have no need for a font I usually disable it. My goal is to only have
fonts on my system I actually want.

## conf.d folder

#### 10-sub-pixel-rgb.conf
Improves sharpness of font rendering.
#### 11-lcdfilter-default.conf
Reduce color fringing due to subpixel rendering.
#### 68-icons.conf
Defines the icons font family containing the awesome-terminal fonts.
The icons font is also family configured as fallback font for the
three fontfamilies.
#### 69-emoji.conf
Defines the emoji font family. The emoji font family is also
configured as fallback font for the three fontfamilies.
#### 70-block-bitmaps.conf
Bitmap fonts are ugly. They are now disabled.
#### 71-block-dejavu.conf
*DejaVu* has too many ugly emoji glyphs which prevent the glyphs of my
default emoji font to be displayed.  Hence *DejaVu* is - and will
always be - disabled in my fontconfig. Use *Bitstream Vera* instead.
#### 71-block-vera.conf
*Bitstream Vera* is for the most part identical to *DejaVu*, but does
not have emojis. This is exactly what we want because we configured a
fallback emoji font in [69-emoji.conf](conf.d/69-emoji.conf). No fonts
are blocked for *Bitstream Vera*.
#### 71-block-ms.conf
The font collection `ttf-ms-fonts` and `ttf-vista-fonts` provide a
nice collection of fonts for better compatibility with MS Office. That
said, we don't need *all* of the fonts provided by these two packages.
#### 71-block-droid.conf
Only *Droid Serif*, *Droid Sans* and *Droid Sans Mono* remain available.
#### 71-block-droid.conf
Only *Droid Serif*, *Droid Sans* and *Droid Sans Mono* remain available.
#### 71-block-cantarell.conf
Only *Cantarell* with styles *Regular* and *Bold* remains available.
#### 71-block-libertine.conf
Only *Linux Libertine* and *Linux Biolinum* remain available.
#### 71-block-gsfonts
Only *Nimbus Sans* and *Numbus Roman* remain available.
#### 71-block-adobe.conf
Only *Source Code Pro* with styles *Regular*, *Bold* and *Italic* remains available.
#### 71-block-hack.conf
Only *Hack Nerd Font* with styles *Regular* and *Bold* remains available.
#### 71-block-liberation.conf
No *Liberation fonts* are blocked.
#### 71-block-gnu-fonts.conf
No *GNU fonts* are blocked.
#### 72-block-emoji.conf
All common emoji fonts except the one I'm using are blocked.
