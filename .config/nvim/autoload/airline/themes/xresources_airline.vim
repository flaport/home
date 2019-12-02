" vim-airline template by ronald2wing (https://github.com/ronald2wing)
" Base 16 Gruvbox Dark Hard Scheme by Dawid Kurek (https://github.com/dawikur)
let g:airline#themes#xresources_airline#palette = {}
let s:gui00 = "#32302F"
let s:gui01 = "#CC241D"
let s:gui02 = "#98971A"
let s:gui03 = "#D79921"
let s:gui04 = "#458588"
let s:gui05 = "#B16286"
let s:gui06 = "#689D6A"
let s:gui07 = "#EBDBB2"
let s:gui08 = "#928374"
let s:gui09 = "#FB4934"
let s:gui0A = "#B8BB26"
let s:gui0B = "#FABD2F"
let s:gui0C = "#83A598"
let s:gui0D = "#D3869B"
let s:gui0E = "#8EC07C"
let s:gui0F = "#EBDBB2"

let s:cterm00 = 0
let s:cterm01 = 1
let s:cterm02 = 2
let s:cterm03 = 3
let s:cterm04 = 4
let s:cterm05 = 5
let s:cterm06 = 6
let s:cterm07 = 7
let s:cterm08 = 8
let s:cterm09 = 9
let s:cterm0A = 10
let s:cterm0B = 11
let s:cterm0C = 12
let s:cterm0D = 13
let s:cterm0E = 14
let s:cterm0F = 15

let s:N1   = [ s:gui00, s:gui0B, s:cterm09, s:cterm0B ]
let s:N2   = [ s:gui00, s:gui06, s:cterm00, s:cterm06 ]
let s:N3   = [ s:gui09, s:gui00, s:cterm00, s:cterm04 ]
let g:airline#themes#xresources_airline#palette.normal = airline#themes#generate_color_map(s:N1, s:N2, s:N3)

let s:I1   = [ s:gui00, s:gui04, s:cterm03, s:cterm05 ]
let s:I2   = [ s:gui00, s:gui06, s:cterm00, s:cterm06 ]
let s:I3   = [ s:gui09, s:gui00, s:cterm00, s:cterm04 ]
let g:airline#themes#xresources_airline#palette.insert = airline#themes#generate_color_map(s:I1, s:I2, s:I3)

let s:R1   = [ s:gui00, s:gui08, s:cterm09, s:cterm08 ]
let s:R2   = [ s:gui00, s:gui02, s:cterm00, s:cterm02 ]
let s:R3   = [ s:gui09, s:gui00, s:cterm00, s:cterm04 ]
let g:airline#themes#xresources_airline#palette.replace = airline#themes#generate_color_map(s:R1, s:R2, s:R3)

let s:V1   = [ s:gui00, s:gui09, s:cterm0B, s:cterm09 ]
let s:V2   = [ s:gui00, s:gui06, s:cterm00, s:cterm06 ]
let s:V3   = [ s:gui09, s:gui00, s:cterm00, s:cterm04 ]
let g:airline#themes#xresources_airline#palette.visual = airline#themes#generate_color_map(s:V1, s:V2, s:V3)

let s:IA1   = [ s:gui05, s:gui00, s:cterm0B, s:cterm00 ]
let s:IA2   = [ s:gui05, s:gui00, s:cterm05, s:cterm00 ]
let s:IA3   = [ s:gui05, s:gui00, s:cterm00, s:cterm04 ]
let g:airline#themes#xresources_airline#palette.inactive = airline#themes#generate_color_map(s:IA1, s:IA2, s:IA3)

" Here we define the color map for ctrlp.  We check for the g:loaded_ctrlp
" variable so that related functionality is loaded iff the user is using
" ctrlp. Note that this is optional, and if you do not define ctrlp colors
" they will be chosen automatically from the existing palette.
if !get(g:, 'loaded_ctrlp', 0)
  finish
endif
let g:airline#themes#xresources_airline#palette.ctrlp = airline#extensions#ctrlp#generate_color_map(
      \ [ s:gui15, s:gui02, s:cterm15, s:cterm02, '' ],
      \ [ s:gui15, s:gui04, s:cterm15, s:cterm04, '' ],
      \ [ s:gui05, s:gui00, s:cterm05, s:cterm00, 'bold' ])

