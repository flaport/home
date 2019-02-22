"        _
" __   _(_)_ __ ___  _ __ ___
" \ \ / / | '_ ` _ \| '__/ __|
"  \ V /| | | | | | | | | (__
"   \_/ |_|_| |_| |_|_|  \___|

" DEPENDENCIES
" ============

" load plugins
source ~/.config/nvim/plugins.vim

" F-MAPPINGS
" ==========

" edit config from inside vim:
nnoremap <F2> :w<CR>:e ~/.config/nvim/init.vim<CR>
inoremap <F2> <Esc>:w<CR>:e ~/.config/nvim/init.vim<CR>

" execute / compile file
nnoremap <F5> :w<CR>:!~/.config/nvim/run %<CR>
inoremap <F5> <Esc><F5>
vnoremap <F5> "+y:w<CR>:!~/.config/nvim/run_selection %<CR>
"<Esc>:w<CR>:!~/.config/nvim/run %<CR>

" include a screenshot into markdown as image
vnoremap <F3> "*d:!python3 ~/.config/nvim/screenshot<CR>a![<Esc>"*pa](<Esc>"*pa)<Esc>

" built in spell checker:
" use zg to add a word to the dictionary
" use zuw to remove word from dictionary
" use ]s and [s to navigate between misspelled words
" use z= to find a suggestion for the misspelled word
nnoremap <F6> :setlocal spell! spelllang=en_gb<CR>
inoremap <F6> <Esc>:setlocal spell! spelllang=en_gb<CR>
nnoremap zx z=1<CR><CR>


" MAPPINGS
" =====================

" insert mode remaps
inoremap jj <Esc>

" sane split navigation
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" save buffer
nnoremap <C-s> :w<CR>
inoremap <C-s> <Esc>:w<CR>

" exit
nnoremap <C-c> :qa!<CR>
inoremap <C-c> <Esc>:qa!<CR>
nnoremap <C-q> :wqa<CR>
inoremap <C-q> <Esc>:wqa<CR>

" MARKDOWN
" ========
" follow markdown link:
nnoremap <Leader>d ie <Esc>vh"ax"Ayi(:w<CR>:@a<CR>

" LATEX
" =====
" synctex forward <Leader>s
function! SyncTexForward()
    let execstr = "silent !zathura --synctex-forward ".line(".").":".col(".").":%:p %:p:r.pdf &"
    exec execstr
endfunction
au FileType tex nmap <Leader>s :call SyncTexForward()<CR>
" synctex backward: Ctrl-Click
" NOTE: for backward synctex to work, one has to run neovim-remote on port 9999:
" nvr --servername 127.0.0.1:9999 filename.tex
" And add the following two lines to zathurarc:
" set synctex true
" set synctex-editor-command "nvr --servername 127.0.0.1:9999 +%{line} %{input}"


" SETTINGS
" ========

" magic
set magic

" splits appear below/right
set splitbelow
set splitright

" enable utf-8
set encoding=utf-8

" go to folder containing current file
autocmd BufEnter * silent! lcd %:p:h

" smart case (in)sensitive search
:set ignorecase
:set smartcase

" disable word wrap
set nowrap

" set a column at 90 characters
set colorcolumn=90

" enable syntax highlighting
syntax enable

" copy to star register by default (selection copy)
set clipboard^=unnamed

" underline current line if in insert mode:
:autocmd InsertEnter * set cul
:autocmd InsertLeave * set nocul

" clear empty spaces at the end of lines on save of python files
autocmd BufWritePre *.py :%s/\s\+$//e

" show line numbers
set number

" set tabs to have 4 spaces
set tabstop=4
set softtabstop=4
set shiftwidth=4

" easy cycling through code completion
inoremap <C-j> <C-n>
inoremap <C-k> <C-p>

" indent when moving to the next line while writing code
" set autoindent
set noautoindent

" expand tabs into spaces
set expandtab

" when using the >> or << commands, shift lines by 4 spaces
set shiftwidth=4

" show the matching part of the pair for [] {} and ()
set showmatch

" enable all Python syntax highlighting features
let python_highlight_all = 1

" remove ugly vertical lines on window division
set fillchars+=vert:\ 

" save as sudo
ca w!! w !sudo tee "%"

" when scrolling, keep cursor 3 lines away from screen border
set scrolloff=3

" fix problems with uncommon shells (fish, xonsh) and plugins running commands
" (neomake, ...)
set shell=/bin/bash 

" code folding
" zM: fold all; zR: unfold all; za: toggle fold, zv: unfold one; zc: fold one
set foldmethod=indent

" enable different behavior for different filetypes:
set nocompatible
filetype plugin on

" COLORSCHEMES
" ===========
" use 256 colors when possible
" set notermguicolors
" set termguicolors

" white colorscheme
" colorscheme delek

" dark colorscheme
" colorscheme material

" fisa colorscheme
" colorscheme fisa

" OTHER COMMANDS
" =============
" - : window chooser
" <Leader>e: open file
" <Leader>c: run command
" <Leader>f: find
" <Leader>d: goto definition
" <Leader>t: open file browser

