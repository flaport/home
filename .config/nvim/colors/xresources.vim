" Vim xresources color file
"    _____ _     ____  ____  ____  ____  _____
"   /    // \   /  _ \/  __\/  _ \/  __\/__ __\
"   |  __\| |   | / \||  \/|| / \||  \/|  / \
"   | |   | |_/\| |-|||  __/| \_/||    /  | |
"   \_/   \____/\_/ \|\_/   \____/\_/\_\  \_/
"
set background=dark
let g:colors_name="xresources"

" color terminal definitions
hi ColorColumn ctermbg=4
hi Comment	ctermfg=6
hi Constant	ctermfg=13
hi DiffAdd	ctermbg=4
hi DiffChange	ctermbg=5
hi DiffDelete	cterm=bold ctermfg=4 ctermbg=6
hi DiffText	cterm=bold ctermbg=9
hi Directory	ctermfg=6
hi Error    cterm=bold ctermfg=1 ctermbg=none
hi ErrorMsg	cterm=bold ctermfg=15 ctermbg=9
hi FoldColumn	ctermfg=8 ctermbg=NONE
hi Folded	ctermfg=15 ctermbg=8
hi Identifier	ctermfg=4
hi Ignore	cterm=bold ctermfg=7
hi Ignore	ctermfg=8
hi IncSearch	cterm=NONE ctermfg=15 ctermbg=6
hi LineNr	ctermfg=3
hi MatchParen	cterm=NONE ctermfg=3
hi ModeMsg	cterm=NONE ctermfg=1
hi MoreMsg	ctermfg=2
hi NonText	cterm=bold ctermfg=4
hi PreProc	ctermfg=13
hi Question	ctermfg=2
hi Search	cterm=NONE ctermfg=15 ctermbg=6
hi SignColumn ctermbg=NONE
hi Special	ctermfg=3
hi SpecialKey	ctermfg=2
hi SpellBad cterm=bold ctermfg=9 ctermbg=none
hi SpellCap cterm=underline ctermfg=9 ctermbg=none
hi SpellErrors cterm=underline ctermfg=1 ctermbg=none
hi SpellLocal cterm=underline ctermfg=9 ctermbg=none
hi SpellRare cterm=underline ctermfg=9 ctermbg=none
hi Statement    cterm=bold	ctermfg=3
hi StatusLine	cterm=bold,reverse
hi StatusLineNC cterm=reverse
hi Title	ctermfg=5
hi Todo	ctermfg=7 ctermbg=2
hi Type		ctermfg=2
hi Underlined	cterm=underline ctermfg=5
hi VertSplit	cterm=NONE ctermbg=NONE
hi Visual	cterm=reverse
hi Warning	ctermfg=7 ctermbg=3
hi WarningMsg	ctermfg=15 ctermbg=3
hi WildMenu	ctermfg=0 ctermbg=3
" Ciacconas change
" CocUnused fg to lighter color background stay 242 as a middle gray
hi Conceal ctermfg=11 ctermbg=8
" CocHighlightText bg word highlight to a lighter gray
hi CursorColumn ctermbg=8
" CocFloat bg color
hi Pmenu ctermfg=15 ctermbg=8
hi PmenuSel ctermfg=7 ctermbg=0
" Coc Float InfoSign and HintSign
hi CocWarningSign ctermfg=11
hi CocInfoSign ctermfg=10
hi CocHintSign ctermfg=12


