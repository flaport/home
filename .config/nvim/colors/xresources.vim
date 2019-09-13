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
hi SpecialKey	ctermfg=2
hi NonText	cterm=bold ctermfg=4
hi Directory	ctermfg=6
hi Todo	ctermfg=7 ctermbg=2
hi Error    cterm=bold ctermfg=1 ctermbg=none
hi Warning	ctermfg=7 ctermbg=3
hi ErrorMsg	cterm=bold ctermfg=15 ctermbg=9
hi WarningMsg	ctermfg=15 ctermbg=3
hi IncSearch	cterm=NONE ctermfg=15 ctermbg=6
hi Search	cterm=NONE ctermfg=15 ctermbg=6
hi MoreMsg	ctermfg=2
hi ModeMsg	cterm=NONE ctermfg=1
hi LineNr	ctermfg=3
hi Question	ctermfg=2
hi StatusLine	cterm=bold,reverse
hi StatusLineNC cterm=reverse
hi VertSplit	cterm=reverse
hi Title	ctermfg=5
hi Visual	cterm=reverse
hi WildMenu	ctermfg=0 ctermbg=3
hi Folded	ctermfg=8 ctermbg=15
hi FoldColumn	ctermfg=8 ctermbg=NONE
hi DiffAdd	ctermbg=4
hi DiffChange	ctermbg=5
hi DiffDelete	cterm=bold ctermfg=4 ctermbg=6
hi DiffText	cterm=bold ctermbg=9
hi Comment	ctermfg=6
hi Constant	ctermfg=13
hi Special	ctermfg=3
hi Identifier	ctermfg=4
hi Statement    cterm=bold	ctermfg=3
hi PreProc	ctermfg=13
hi Type		ctermfg=2
hi Underlined	cterm=underline ctermfg=5
hi Ignore	cterm=bold ctermfg=7
hi Ignore	ctermfg=8
hi SpellBad cterm=bold ctermfg=9 ctermbg=none
hi SpellErrors cterm=underline ctermfg=1 ctermbg=none
hi SpellCap cterm=underline ctermfg=9 ctermbg=none
hi SpellLocal cterm=underline ctermfg=9 ctermbg=none
hi SpellRare cterm=underline ctermfg=9 ctermbg=none

