"    _____ _     ____  ____  ____  ____  _____ 
"   /    // \   /  _ \/  __\/  _ \/  __\/__ __\
"   |  __\| |   | / \||  \/|| / \||  \/|  / \  
"   | |   | |_/\| |-|||  __/| \_/||    /  | |  
"   \_/   \____/\_/ \|\_/   \____/\_/\_\  \_/  
"

"" Plugins
"-------------------------------------------------------------------------------

" load plugins
source ~/.config/nvim/plugins.vim


"" Useful commands inherited from plugins (incomplete list)
"-------------------------------------------------------------------------------

" fuzzy open file
" <Leader>e

" fuzzy run vim command
" <Leader>c

" fuzzy find in file
" <Leader>f

" go to definition (python)
" <Leader>d

" open file browser
" <Leader>t


"" All mode shortcuts
"-------------------------------------------------------------------------------

" sometimes, shortcuts here are twice defined, once as normal mode shortcut
" and once as insert mode shortcut. This is on purpose, as defining it once
" (with for example the `map` keyword) does not always have the intended
" behavior

" save buffer
inoremap <C-s> <Esc>:w<CR>
nnoremap <C-s> <Esc>:w<CR>

" exit without saving
inoremap <C-c> <Esc>:qa!<CR>
nnoremap <C-c> <Esc>:qa!<CR>

" save and exit
inoremap <C-q> <Esc>:wqa<CR>
nnoremap <C-q> <Esc>:wqa<CR>


"" Insert mode shortcuts
"-------------------------------------------------------------------------------

" exit insert mode
inoremap jj <Esc>


"" Normal mode shortcuts
"-------------------------------------------------------------------------------

" set leader key
let mapleader = " "

" latex synctex forward
" <Leader>s
function! SyncTexForward()
    let execstr = "silent !zathura --synctex-forward ".line(".").":".col(".").":%:p %:p:r.pdf &"
    exec execstr
endfunction
au FileType tex nmap <Leader>s :call SyncTexForward()<CR>

" latex synctex backward
" Ctrl-Click
" NOTE: for backward synctex to work, one has to run neovim-remote on port 9999:
" nvr --servername 127.0.0.1:9999 filename.tex
" And add the following two lines to zathurarc:
" set synctex true
" set synctex-editor-command "nvr --servername 127.0.0.1:9999 +%{line} %{input}"
" normally, the custom nvim script in the nvim config folder will execute nvr
" in stead of nvim when a latex file is opened.


"" Navigation
"-------------------------------------------------------------------------------

" move to split below of current split
nnoremap <C-j> <C-w>j

" move to split above of current split
nnoremap <C-k> <C-w>k

" move to split left of current split
nnoremap <C-h> <C-w>h

" move to split right of current split
nnoremap <C-l> <C-w>l


"" Function keys
"-------------------------------------------------------------------------------

" edit this configuration file
nnoremap <F2> :w<CR>:e ~/.config/nvim/init.vim<CR>
inoremap <F2> <Esc>:w<CR>:e ~/.config/nvim/init.vim<CR>

" save and execute file (requires tmux and i3)
nnoremap <F5> :w<CR>:silent !~/.config/nvim/run %<CR>
inoremap <F5> <Esc>:w<CR>:silent !~/.config/nvim/run %<CR>

" save and execute selection
vnoremap <F5> "+y:w<CR>:!~/.config/nvim/run_selection %<CR>

" enable spell checker:
nnoremap <F6> :setlocal spell! spelllang=en_us<CR>
inoremap <F6> <Esc>:setlocal spell! spelllang=en_us<CR>
" use zg to add a word to the dictionary
" use zuw to remove word from dictionary
" use ]s and [s to navigate between misspelled words
" use z= to find a suggestion for the misspelled word


"" Settings
"-------------------------------------------------------------------------------

" enable different behavior for different filetypes:
set nocompatible
filetype plugin on

" automatically cd into folder of current file
autocmd BufEnter * silent! lcd %:p:h

" enable syntax highlighting
syntax enable

" underline current line if in insert mode
:autocmd InsertEnter * set cul

" remove underline when in normal mode
:autocmd InsertLeave * set nocul

" clear trailing spaces in python files at saving
autocmd BufWritePre *.py :%s/\s\+$//e

" enable all Python syntax highlighting features
let python_highlight_all = 1

" save as sudo (make sure SUDO_ASKPASS is set to a password asking program)
ca w!! w !sudo -A tee '%' &> /dev/null

" remove ugly vertical lines in split
set fillchars+=vert:\ 

" fix problems with uncommon shells (fish, zsh, xonsh, ...) and plugins 
" running shell commands (neomake, ...)
set shell=/bin/bash 

" set a column at 90 characters
set colorcolumn=90

" disable line wrapping
set nowrap

" allow pattern matching with special characters
set magic

" new vertical splits appear on the right
set splitright

" new horizontal splits appear below
set splitbelow

" enable unicode
set encoding=utf-8

" case insensitive search when searching with lower case characters
:set ignorecase

" case sensitive search when searching with upper case characters
:set smartcase

" copy to star register by default (selection copy)
set clipboard^=unnamed

" show line numbers
set number

" set tabs to have a width of 4 spaces
set tabstop=4

" set tabs to have a maximum width of 4 spaces
set softtabstop=4

" set the shift operators (`<<` and `>>`) to insert 4 spaces
set shiftwidth=4

" replace tabs by spaces
set expandtab

" disable automatic indent when moving to the next line while writing code
set noautoindent

" show the matching part of the pair for [] {} and ()
set showmatch

" when scrolling, keep cursor 3 lines away from screen border
set scrolloff=3

" code folding
" zM: fold all; zR: unfold all; za: toggle fold, zv: unfold one; zc: fold one
set foldmethod=indent


"" Theme / colorscheme
"-------------------------------------------------------------------------------

" use 256 colors when possible
" set notermguicolors
" set termguicolors

" white colorscheme
" colorscheme delek

" dark colorscheme
" colorscheme material

" fisa colorscheme
" colorscheme fisa

