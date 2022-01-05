" Vim xresources color file
"    _____ _     ____  ____  ____  ____  _____
"   /    // \   /  _ \/  __\/  _ \/  __\/__ __\
"   |  __\| |   | / \||  \/|| / \||  \/|  / \
"   | |   | |_/\| |-|||  __/| \_/||    /  | |
"   \_/   \____/\_/ \|\_/   \____/\_/\_\  \_/
"
set background=dark
let g:colors_name="xresources"
" All the commented hi commands are the default ones from neovim and Treesitter.
" They are there just for better understanding of different highlight options and
"  for easier further customizations


" Treesitting related (code highlighting related) ----------------------------
" Strong Purple Magenta 13
hi Constant	ctermfg=13 " TSConstant
" hi link Character Constant " TSCharacter
" hi link String Constant " TSString TSLiteral
" hi link Boolean Constant " Boolean TSBoolean
" hi link Number Constant " TSNumber
" hi link Float Constant " TSFloat

" Strong Cyan Aqua 14
hi TSKeywordFunction cterm=bold	ctermfg=14 " TSKeywordFunction
hi link TSKeywordReturn TSKeywordFunction
" Weak Cyan Aqua 6
hi PreProc ctermfg=6 " TSAnnotation TSAttribute
" hi link Define PreProc " Macro TSConstMacro TSFuncMacro
" hi link Include PreProc " TSInclude TSNamespace

" Strong Green 10
hi Function cterm=bold ctermfg=10 " TSFunction TSMethod
" Weak Green 2
hi Special ctermfg=2 " SpecialChar TSStringSpecial TSVariableBuiltin TSFuncBuiltin

" Strong Blue 12
hi Identifier cterm=none ctermfg=12 " TSParameter
" Weak Blue 4
hi Type cterm=italic ctermfg=4 " TSType

" Strong Yellow 11
hi Statement cterm=bold	ctermfg=11
" hi link Keyword Statement " TSKeyword
" hi link Conditional Statement " TSConditional
" hi link Operator Statement " TSOperator
" hi link Repeat Statement " TSRepeat
" hi link Label Statement " TSLabel
" hi link Exception Statement " TSException
" Weak Yellow 3

" Strong Foregound fg 15
" Weak Foregound fg 7
" hi Special ctermfg=7 " SpecialChar TSStringSpecial TSVariableBuiltin TSFuncBuiltin
hi Delimiter cterm=bold ctermfg=7 " TSDelimiter TSPunctBracket TSPunctSpecial
hi Comment	ctermfg=7 " TSComment


" Quickscope related -------------------------------
hi QuickScopePrimary cterm=bold ctermfg=4

" Coc related -------------------------------
" Code Folding
hi Folded   ctermfg=7 ctermbg=None cterm=bold
" CocHighlightText weaker bg
hi CursorColumn ctermbg=8
" CocFloat suggestion menu window
hi Pmenu ctermfg=15 ctermbg=5
hi PmenuSel ctermfg=7 ctermbg=0
" Coc InfoSign and HintSign
hi CocWarningSign ctermfg=11
hi CocInfoSign ctermfg=10
hi CocHintSign ctermfg=12
" CocUnused highlight
hi Conceal ctermfg=11 ctermbg=8

" TUI related ----------------------------
" Search
hi Search	cterm=NONE ctermfg=15 ctermbg=6
hi IncSearch	cterm=bold ctermfg=15 ctermbg=6
hi ColorColumn ctermbg=4
hi DiffAdd	ctermbg=4
hi DiffChange	ctermbg=5
hi DiffDelete	cterm=bold ctermfg=4 ctermbg=6
hi DiffText	cterm=bold ctermbg=9
hi Directory	ctermfg=6
hi Error    cterm=bold ctermfg=1 ctermbg=none
hi ErrorMsg	cterm=bold ctermfg=15 ctermbg=9
hi FoldColumn	ctermfg=8 ctermbg=NONE
hi Ignore	cterm=bold ctermfg=7
hi Ignore	ctermfg=8
hi LineNr	ctermfg=3
hi MatchParen	cterm=NONE ctermfg=3
hi ModeMsg	cterm=NONE ctermfg=1
hi MoreMsg	ctermfg=2
hi NonText	cterm=bold ctermfg=4
hi Question	ctermfg=2
hi SignColumn ctermbg=NONE
hi SpecialKey	ctermfg=2
hi SpellBad cterm=bold ctermfg=9 ctermbg=none
hi SpellCap cterm=underline ctermfg=9 ctermbg=none
hi SpellErrors cterm=underline ctermfg=1 ctermbg=none
hi SpellLocal cterm=underline ctermfg=9 ctermbg=none
hi SpellRare cterm=underline ctermfg=9 ctermbg=none
hi StatusLine	cterm=bold,reverse
hi StatusLineNC cterm=reverse
hi Title	cterm=bold ctermfg=10
hi Todo	ctermfg=7 ctermbg=2
hi Underlined	cterm=underline ctermfg=12 " TSURI
hi VertSplit	cterm=NONE ctermbg=NONE
hi Visual	cterm=reverse
hi Warning	ctermfg=7 ctermbg=3
hi WarningMsg	ctermfg=15 ctermbg=3
hi WildMenu	ctermfg=0 ctermbg=3




