"    _____ _     ____  ____  ____  ____  _____
"   /    // \   /  _ \/  __\/  _ \/  __\/__ __\
"   |  __\| |   | / \||  \/|| / \||  \/|  / \
"   | |   | |_/\| |-|||  __/| \_/||    /  | |
"   \_/   \____/\_/ \|\_/   \____/\_/\_\  \_/
"
" jump to this file from anywhere: <leader>cc


"" Plugins
"-------------------------------------------------------------------------------
" jump to plugins file from anywhere: <leader>cp

if filereadable(expand("~/.config/nvim/plugins.vim"))
    source ~/.config/nvim/plugins.vim
endif


"" Snippets
"-------------------------------------------------------------------------------
" jump to snippets file from anywhere: <leader>cs

if filereadable(expand("~/.config/nvim/snippets.vim"))
    source ~/.config/nvim/snippets/snippets.vim
endif


"" Filetypes
"-------------------------------------------------------------------------------

" define custom filetypes
augroup filetypes
    autocmd!
    autocmd BufNewFile,BufEnter,BufRead * filetype on
    autocmd BufNewFile,BufEnter,BufRead * filetype plugin on
    autocmd BufNewFile,BufEnter,BufRead * filetype indent on
    autocmd BufNewFile,BufEnter,BufRead *.vim setlocal filetype=vim
    autocmd BufNewFile,BufEnter,BufRead *.ipynb setlocal filetype=ipynb
    autocmd BufNewFile,BufEnter,BufRead *.tex,*.sty setlocal filetype=tex
    autocmd BufNewFile,BufEnter,BufRead *.md,/tmp/calcurse*,~/.calcurse/notes/*,/tmp/neomutt* call SetFiletypeMarkdownLike()
augroup end
function! SetFiletypeMarkdownLike()
    if fnamemodify(expand('%'), ':p:h') == expand('~/VimWiki')
        setlocal filetype=vimwiki
    else
        setlocal filetype=markdown
    endif
endfunction


"" Fixed Settings
"-------------------------------------------------------------------------------
" these settings won't change, no matter the filetype or active extension

" set leader key
let mapleader = " "

" when scrolling, keep cursor in the middle of the page (disabled, use zz to center)
" set scrolloff=1000
set scrolloff=10

" allow pattern matching with special characters during search
set magic

" case insensitive search when searching with lower case characters
set ignorecase

" case sensitive search when searching with upper case characters
set smartcase

" enable unicode
set encoding=utf-8

" when searching, search down into all subfolders
set path+=**

" allow opening a new buffer without saving the current one
set hidden

" new vertical splits appear on the right
set splitright

" new horizontal splits appear below
set splitbelow

" tell vim where to find the ctags
set tags=./.tags;,.tags;

" enable mouse clicks
set mouse=a

" copy to star register by default (selection copy)
set clipboard^=unnamed

" replace tabs by spaces
set expandtab

" set tabs to have a width of 4 spaces
set tabstop=4

" set tabs to have a maximum width of 4 spaces
set softtabstop=4

" set the shift operators (`<<` and `>>`) to insert 4 spaces
set shiftwidth=4

" code folding
" zM: fold all; zR: unfold all; za: toggle fold, zv: unfold one; zc: fold one
set foldmethod=indent

" show the matching part of the pair for [] {} and ()
set showmatch

" fix problems with uncommon shells (fish, zsh, xonsh, ...) and plugins
" running shell commands (neomake, ...)
set shell=/usr/bin/zsh

" lower updatetime (for vim signify)
set updatetime=200

" better autocomplete:
set wildmenu

" enable unlimited undo
set undofile

" set undi directory where unlimited history can be saved
set undodir=$HOME/.local/share/nvim/undo

" use 256 colors if possible
set notermguicolors

" custom colorscheme using only colors from ~/.Xresources.
colorscheme xresources

" override some colors of colorscheme
hi FoldColumn ctermbg=NONE

" some say this results in an improved wildmenu. I disagree...
" set wildmode=longest,longest,full

" enable syntax highlighting
syntax enable

" disable netrw banner
let g:netrw_banner=0

augroup fixedsettings
    autocmd!

    " underline current line if in insert mode
    autocmd InsertEnter * set cul

    " remove underline when in normal mode
    autocmd InsertLeave * set nocul


    " disable automatic commenting on newline:
    autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

    " automatically cd into folder of current file (disabled, but mapped to <leader>cd)
    "autocmd BufEnter * silent! lcd %:p:h
augroup end


"" Default Variable Settings
"-------------------------------------------------------------------------------
" these settings may change depending on the filetype or active extension

" set the maximum textwidth (at this point a return is inserted if nowrap is set)
set textwidth=90

" set a column at 90 characters
set colorcolumn=90

" disable line wrapping
set nowrap

" disable automatic indent when moving to the next line while writing code
set noautoindent

" show line numbers
set number

" relative line numbering
set relativenumber

" spell check, set default to en_us...
set spell spelllang=en_us

" ...and turn it off by default
set nospell

" left margin width (max 12)
set foldcolumn=2

" show mode currently in (normal, insert, ...)
set noshowmode

" show where you are in the document in status bar (e.g. 143,61, 20%)
set ruler

" show status bar (0=disabled, 1=show half status bar, 2=show full status bar)
set laststatus=2

" don't show last command executed
set noshowcmd

augroup latexmarkdownvariablesettings
    autocmd!

    " set the maximum textwidth (at this point a return is inserted if nowrap is set)
    autocmd FileType tex,markdown,vimwiki setlocal textwidth=80

    " disable color column
    autocmd FileType tex,markdown,vimwiki setlocal colorcolumn=0

    " show line numbers
    autocmd FileType tex,markdown,vimwiki setlocal nonumber

    " relative line numbering
    autocmd FileType tex,markdown,vimwiki setlocal norelativenumber

    " spell check, set default to en_us
    autocmd FileType tex,markdown,vimwiki setlocal spell spelllang=en_us

    " left margin width (max 12)
    autocmd FileType tex,markdown,vimwiki setlocal foldcolumn=12

    " show where you are in the document in status bar (e.g. 143,61, 20%)
    autocmd FileType tex,markdown,vimwiki setlocal noruler

    " show status bar (0=disabled, 1=show half status bar, 2=show full status bar)
    autocmd FileType tex,markdown,vimwiki setlocal laststatus=0

    " don't show last command executed
    autocmd FileType tex,markdown,vimwiki setlocal noshowcmd
augroup end

augroup markdownvariablesettings
    autocmd!

    " disable line wrapping
    autocmd FileType markdown,vimwiki setlocal wrap linebreak
augroup end

augroup pythonvariablesettings
    autocmd!

    " enable autoindent
    autocmd FileType python setlocal autoindent
augroup end

augroup vimvariablesettings
    autocmd!

    " disable color column
    autocmd FileType vim setlocal colorcolumn=0

    " more info in status bar:
    autocmd FileType vim setlocal showmode
augroup end


"" Saving
"-------------------------------------------------------------------------------
" these settings won't change, no matter the filetype or active extension

augroup saving
    autocmd!
    autocmd BufWritePre * :silent call DoOnSave()
    autocmd FocusLost * :silent call MaybeSave()
augroup end

function! DoOnSave()
    delmarks m
    normal mm
    " clear trailing spaces on saving:
    exec '%s/\s\+$//e'
    " format markdown files on save:
    if &filetype == "markdown"
        execute 'CocCommand prettier.formatFile'
    endif
    if &filetype == "vimwiki"
        setlocal filetype=markdown
        execute 'CocCommand prettier.formatFile'
        setlocal filetype=vimwiki
    endif
    normal `m
    delmarks m
endfunction

" save on focus lost
function! MaybeSave()
    if bufname('%') != '' && &filetype != 'nerdtree' && &filetype != 'netrw'
        exec "wa"
    endif
endfunction

" save as sudo (make sure SUDO_ASKPASS is set to a password asking program)
function! SaveAsSudo()
    execute 'silent write !sudo -A tee % >/dev/null' | edit!
endfunction
cabbrev w!! call SaveAsSudo()

" open as sudo (make sure SUDO_ASKPASS is set to a password asking program)
function! OpenAsSudo()
    let numbuffers = len(getbufinfo({'buflisted':1}))
    if numbuffers > 1
        execute 'echo "cannot open as sudo if more than 1 buffer open.\nYou have '.numbuffers.' buffers open."'
    endif
    call SaveAsSudo()
    execute 'silent write !nvim_close_and_open_as_sudo % & disown' | edit!
endfunction
cabbrev e!! call OpenAsSudo()


"" Custom Commands
"-------------------------------------------------------------------------------
" these commands may change depending on the filetype or active extension

command! T call NewTerminal("")
command! HT call NewHorizontalTerminal("")
command! VT call NewVerticalTerminal("")

augroup terminal
  autocmd!
  autocmd TermOpen * call OnTerminalOpen()
  autocmd TermClose * call OnTerminalClose()
augroup end

augroup pythonterminal
    autocmd!

    autocmd FileType python command! T call NewTerminal("ipython --matplotlib")
    autocmd FileType python command! HT call NewHorizontalTerminal("ipython --matplotlib")
    autocmd FileType python command! VT call NewVerticalTerminal("ipython --matplotlib")
augroup end

function! OnTerminalOpen()
    let g:last_terminal_job_id = b:terminal_job_id
endfunction
function! OnTerminalClose()
    if exists("g:last_terminal_job_id")
        unlet g:last_terminal_job_id
    endif
endfunction

function! NewTerminal(shell)
    execute "terminal ".a:shell
endfunction
function! NewHorizontalTerminal(shell)
    execute "split | resize 10 | terminal ".a:shell
    execute "normal G\<C-w>k"
endfunction
function! NewVerticalTerminal(shell)
    execute "vsplit | terminal ".a:shell
    execute "normal G\<C-w>h"
endfunction


"" Fixed Keyboard Shortcuts
"-------------------------------------------------------------------------------
" these keyboard shortcuts won't change, no matter the filetype or active extension

" back to normal mode (just use escape, man...)
" inoremap jj <Esc>

" go to edit mode in terminal emulator:
" the backtick is there to not interfere with the <Esc> of the shell itself.
tnoremap `<Esc> <C-\><C-n>

" use K to show documentation in preview window (reqruires neoclide/coc.nvim)
nnoremap <silent> K :call ShowDocumentation()<CR>

" remap 'n' and 'N' to center screen after jumping to next match
nnoremap n nzz
nnoremap N Nzz

" Use `[g` and `]g` to navigate diagnostics (requires neoclide/coc.nvim)
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" go to next misspelled word (enable spell checker with F3)
" ]s " standard vim keybinding

" go to previous misspelled word (enable spell checker with F3)
" [s " standard vim keybinding

" show suggestion for misspelled word (enable spell checker with F3)
" z= " standard vim keybinding

" add a word to the dictionary (enable spell checker with F3)
" zg " standard vim keybinding

" remove word from dictionary (enable spell checker with F3)
" zuw " standard vim keybinding

" fold all
" zM " standard vim keybinding

" unfold all
" zR " standard vim keybinding

" toggle fold
" za " standard vim keybinding

" unfold one
" zv " standard vim keybinding

" fold one
" zc " standard vim keybinding

" toggle comments
" gc " from vim-commentary plugin

" Set mark
" m{letter}

" jump to mark
" `{letter}

" jump to beginning of line at mark
" '{letter}

" search forward for {pattern}
" /{pattern}

" search forward for {pattern} and go {offset} lines up or down
" /{pattern}/{offset} " Search forward for {pattern} and go {offset} lines up or down.

" search forward for last used pattern
" /<CR>

" repeat the latest "/" or "?" [count] times.
" n

" repeat the latest "/" or "?" [count] times in opposite direction.
" N

" and many many more ;-)


"" Fixed CTRL-based Keyboard Shortcuts
"-------------------------------------------------------------------------------
" these keyboard shortcuts won't change, no matter the filetype or active extension

" increase number
" <C-a> " standard vim keybinding

" scroll page backward
" <C-b> " standard vim keybinding

" exit current buffer without saving
function! CloseBuffer()
    try
        exec DWMClose()
    catch
        if &filetype == "netrw"
            exec "bd!"
        else
            let numbuffers = len(getbufinfo({'buflisted':1}))
            if numbuffers > 1
                exec "bd!"
            else
                exec "qa!"
            endif
        endif
    endtry
endfunction
inoremap <C-c> <Esc>:call CloseBuffer()<CR>
nnoremap <C-c> <Esc>:call CloseBuffer()<CR>

" down half screen
" <C-d> " standard vim keybinding

" scroll text up with cursor staying where it is (opposite of <C-y>)
" <C-e> " standard vim keybinding

" exit terminal mode (same as `<Esc>)
tnoremap <C-e> <C-\><C-N>

" down full screen
" <C-f> " standard vim keybinding

" show status
" <C-g> " standard vim keybinding


" increase master area (requires dwm.vim)
nmap <C-h> <Plug>DWMShrinkMaster
" DISABLED: move to split left of current split (also when in terminal mode)
" nnoremap <C-h> <C-w>h
" tnoremap <C-h> <C-\><C-N><C-w>h

" DISABLED: jump forward in cursor position stack (same as TAB; opposite of <C-o>)
" <C-i> = TAB " standard vim keybinding

" move to next split in clockwise direction (requires dwm.vim)
nmap <C-j> <C-w>w
" DISABLED: move to split below of current split (also when in terminal mode)
" nnoremap <C-j> <C-w>j
" tnoremap <C-j> <C-\><C-N><C-w>j

" move to previous split in anticlockwise direction (requires dwm.vim)
nmap <C-k> <C-w>W
" DISABLED: move to split above of current split (also when in terminal mode)
" nnoremap <C-k> <C-w>k
" tnoremap <C-k> <C-\><C-N><C-w>k

" decrease master area (requires dwm.vim)
nmap <C-l> <Plug>DWMGrowMaster
" DISABLED: move to split right of current split (also when in terminal mode)
" nnoremap <C-l> <C-w>l
" tnoremap <C-l> <C-\><C-N><C-w>l

" move to first non-whitespace of next line
" <C-m> " standard vim keybinding

" create new split in master area (requires dwm.vim)
nmap <C-n> <Plug>DWMNew

" jump backward in cursor position stack (opposite of <C-i> or TAB)
" <C-o> " standard vim keybinding

" fuzzy open file with fzf (requires fzf plugin)
nnoremap <C-p> :Files<CR>

" save and exit
inoremap <C-q> <Esc>:wqa<CR>
nnoremap <C-q> <Esc>:wqa<CR>

" redo
" <C-r> " standard vim keybinding

" save buffer
inoremap <C-s> <Esc>:w<CR>
nnoremap <C-s> <Esc>:w<CR>

" go one step back in tag stack
" <C-t> " standard vim keybinding

" up half screen
" <C-u> " standard vim keybinding

" visual block
" <C-v> " standard vim keybinding

" navigate between splits
" <C-w> " standard vim keybinding

" leader for autocomplete
" <C-x> " standard vim keybinding

" scroll text down with cursor staying where it is (opposite of <C-e>)
" <C-y> " standard vim keybinding

" suspend (like any other terminal process)
" <C-z> " standard shell keybinding

" cancel / go to normal mode
" <C-[> " standard vim keybinding

" use word under cursor to open next file with that tag
" <C-]> " standard vim keybinding

" go to last open buffer
" <C-^> " standard vim keybinding


"" Variable Leader-based Keyboard Shortcuts
"-------------------------------------------------------------------------------
" these settings may change depending on the filetype or active extension

" turn of highlighting
nnoremap <leader><leader> :noh<cr>

" open next buffer
nnoremap <leader>] :bnext<CR>

" open previous buffer
nnoremap <leader>[ :bprevious<CR>

" fuzzy find content in current buffer (requires junegunn/fzf)
nnoremap <leader>/ :BLines<CR>

" jump to other/closing tag (requires valloric/MatchTagAlways)
nnoremap <leader>. :MtaJumpToOtherTag<cr>

" noop
nnoremap <leader>a :echo "\<leader\>a"<cr>
nnoremap <leader>A :echo "\<leader\>A"<cr>

" noop
nnoremap <leader>b :echo "\<leader\>b"<cr>
nnoremap <leader>B :echo "\<leader\>B"<cr>

" Show all diagnostics (requires neoclide/coc.nvim)
nnoremap <silent> <leader>ca  :<C-u>CocList diagnostics<cr>

" Manage CoC extensions (requires neoclide/coc.nvim)
nnoremap <silent> <leader>ce  :<C-u>CocList extensions<cr>

" Show CoC commands (requires neoclide/coc.nvim)
nnoremap <silent> <leader>cm  :<C-u>CocList commands<cr>

" Find symbol of current document (requires neoclide/coc.nvim)
nnoremap <silent> <leader>co  :<C-u>CocList outline<cr>

" Search workspace symbols (requires neoclide/coc.nvim)
nnoremap <silent> <leader>ci  :<C-u>CocList -I symbols<cr>

" edit one of the vim config files (requires set hidden)
nnoremap <leader>cc :e ~/.config/nvim/init.vim<CR>
nnoremap <leader>cp :e ~/.config/nvim/plugins.vim<CR>
nnoremap <leader>cs :e ~/.config/nvim/snippets/snippets.vim<CR>
nnoremap <leader>coc :e ~/.config/nvim/coc-settings.vim<CR>
nnoremap <leader>coj :e ~/.config/nvim/coc-settings.json<CR>

" cd into folder containing current file
nnoremap <leader>cd :lcd %:p:h<CR>

" noop
nnoremap <leader>C :echo "\<leader\>C"<cr>

" go to definition (requires neoclide/coc.nvim)
nmap <silent> <leader>d :w<CR><Plug>(coc-definition)

" noop
nnoremap <leader>D :echo "\<leader\>D"<cr>

" noop
nnoremap <leader>E :echo "\<leader\>E"<cr>

" fuzzy find content in all files in tree  (requires junegunn/fzf)
nnoremap <leader>fb :Buffers<CR>
nnoremap <leader>fc :Commands<CR>
nnoremap <leader>ff :Files<CR>
nnoremap <leader>fl :Lines<CR>
nnoremap <leader>fL :BLines<CR>
nnoremap <leader>fm :Marks<CR>
nnoremap <leader>fM :Maps<CR>
nnoremap <leader>ft :Tags<CR>

" autoformat code (requires neoclide/coc.nvim)
xmap <leader>F <Plug>(coc-format-selected)
nmap <leader>F :Format<CR>

" Toggle (git) diff bar (requires mhinz/vim-signify)
nnoremap <leader>g :SignifyToggle<CR>

" go to definition and similar (requires neoclide/coc.nvim)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Toggle Goyo
nnoremap <leader>G :Goyo<CR>

" enable hard mode for training purposes (requires wikitopian/hardmode)
nnoremap <leader>h <Esc>:call ToggleHardMode()<CR>

" noop
nnoremap <leader>H :echo "\<leader\>H"<cr>

"<leader>i: more information (toggle status bar)
nnoremap <leader>i :call ToggleStatusBar()<CR>

" noop
nnoremap <leader>I :echo "\<leader\>I"<cr>

" noop
nnoremap <leader>j :echo "\<leader\>j"<cr>

" do default action for next item (requires neoclide/coc.nvim)
nnoremap <silent> <leader>J  :<C-u>CocNext<CR>

" noop
nnoremap <leader>k :echo "\<leader\>k"<cr>

" do default action for previous item (requires neoclide/coc.nvim)
nnoremap <silent> <leader>K  :<C-u>CocPrev<CR>

" toggle relative line numbers
nnoremap <leader>l :call RelativeNumberToggle()<CR>

" toggle absolute line numbers
nnoremap <leader>L :call AbsoluteNumberToggle()<CR>

" toggle visible marks (requires vim-signature)
nnoremap <leader>m :SignatureToggleSigns<CR>

" noop
nnoremap <leader>M :echo "\<leader\>M"<cr>

" noop
nnoremap <leader>n :echo "\<leader\>n"<cr>
nnoremap <leader>N :echo "\<leader\>N"<cr>

" show only current buffer (overrides above)
nnoremap <leader>o :only<CR>

" noop
nnoremap <leader>O :echo "\<leader\>O"<cr>

" paste from clipboard in stead of selection
function! Paste()
    try
        normal "+p
    catch
        let cwd = getcwd()
        lcd %:p:h
        let description = expand('<cWORD>')
        let filename = system('nvim_clipboard_image img/'.description)
        let @a = " "
        normal "_diW"aD
        let line = "![".description."](".filename.")"
        put =line
        put a
        normal kkJJ
        execute 'lcd '.cwd
    endtry
endfunction
nnoremap <leader>p :call Paste()<CR>

" resume latest CoC list (requires neoclide/coc.nvim)
nnoremap <silent> <leader>P  :<C-u>CocListResume<CR>

" noop
nnoremap <leader>q :echo "\<leader\>q"<cr>
nnoremap <leader>Q :echo "\<leader\>Q"<cr>

" rename symbol (requires neoclide/coc.nvim)
nmap <leader>r <Plug>(coc-rename)

" noop
nnoremap <leader>R :echo "\<leader\>R"<cr>

"<leader>s: sort (visual mode)
vnoremap <leader>s :!sort<CR>

" <buffer> noop
nnoremap <leader>S :echo "\<leader\>S"<cr>

" browse through tags (requires FZF plugin)
nnoremap <leader>t :Tag<CR>

" create tags
nnoremap <leader>T :silent !ctags -f .tags -R .<CR>

" show undotree (requires mbbill/undotree)
nnoremap <leader>u :UndotreeShow<CR><C-w>h

" noop
nnoremap <leader>U :echo "\<leader\>U"<cr>

" noop
nnoremap <leader>v :echo "\<leader\>v"<cr>
nnoremap <leader>V :echo "\<leader\>V"<cr>

" noop
nnoremap <leader>w :echo "\<leader\>w"<cr>
nnoremap <leader>W :echo "\<leader\>W"<cr>

" noop
nnoremap <leader>x :echo "\<leader\>x"<cr>
nnoremap <leader>X :echo "\<leader\>X"<cr>

" noop
nnoremap <leader>y :echo "\<leader\>y"<cr>
nnoremap <leader>Y :echo "\<leader\>Y"<cr>

" focus current split in master area (requires dwm.vim)
nmap <C-space> <Plug>DWMFocus

" noop
nnoremap <leader>Z :echo "\<leader\>Z"<cr>

augroup pythonleadershortcuts
    autocmd!

    " black python formatting for visual selection
    autocmd FileType python xmap <buffer> <leader>F :!black - 2>/dev/null<CR>

    " go to definition (python only) -- inherited from plugins
    " <leader>d
augroup end

augroup latexleadershortcuts
    autocmd!

    autocmd FileType tex nnoremap <buffer> <leader>s :call SyncTex()<CR>
    "FYI: Ctrl-Click  --> latex synctex zathura pdf->tex
augroup end

function! ToggleStatusBar()
    if (&laststatus == 2)
        setlocal noshowmode
        setlocal noruler
        setlocal laststatus=0
        setlocal noshowcmd
    else
        setlocal showmode
        setlocal ruler
        setlocal laststatus=2
        setlocal showcmd
    endif
endfunction

function! RelativeNumberToggle()
    if (&relativenumber == 1)
        setlocal norelativenumber
    else
        setlocal relativenumber
    endif
    setlocal nonumber
endfunc

function! AbsoluteNumberToggle()
    if (&number == 1)
        setlocal nonumber
    else
        setlocal number
    endif
    setlocal norelativenumber
endfunc

function! SyncTex()
    " either do synctex on the pdf with basename [filename without extension] $TEXBASE,
    " or do synctex on the pdf with the same base name as the current tex file if
    " the environment variable $TEXBASE does not exist.
    exec "silent !test -z $TEXBASE && TEXBASE=%:p:r; zathura --synctex-editor-command 'nvr --servername ".v:servername." +\\%{line} \\%{input}' --synctex-forward ".line(".").":".col(".").":%:p $TEXBASE.pdf &"
endfunction


"" Variable Function Key Shortcuts
"-------------------------------------------------------------------------------
" these settings may change depending on the filetype or active extension

" show vim help
" <F1> " standard vim keybinding

" noop
nnoremap <F2> :echo "\<F2\>"<cr>

" toggle spell checker:
nnoremap <F3> <Esc>:setlocal spell!<CR>
inoremap <F3> <Esc>:setlocal spell!<CR>

" choose spell checker language and enable
nnoremap <F3><F3> <Esc>:setlocal spell spelllang=
inoremap <F3><F3> <Esc>:setlocal spell spelllang=

" source init.vim again.
nnoremap <F4> <Esc>:source ~/.config/nvim/init.vim<CR>:edit<CR>
inoremap <F4> <Esc>:source ~/.config/nvim/init.vim<CR>:edit<CR>

" noop
nnoremap <F5> :echo "\<F5\>"<cr>

" noop
nnoremap <F6> :echo "\<F6\>"<cr>

" noop
nnoremap <F7> :echo "\<F7\>"<cr>

" noop
nnoremap <F8> :echo "\<F8\>"<cr>

" noop
nnoremap <F9> :echo "\<F9\>"<cr>

" noop
nnoremap <F10> :echo "\<F10\>"<cr>

" noop
nnoremap <F11> :echo "\<F11\>"<cr>

" noop
nnoremap <F12> :echo "\<F12\>"<cr>

augroup pythonfunctionkeyshortcuts
    autocmd!
    " run cell and jump to next cell (use '##' to mark a cell)
    autocmd FileType python nnoremap <buffer> <CR> :call RunPython("celljump")<cr>
    " run cell and stay (use '##' to mark a cell)
    autocmd FileType python nnoremap <buffer> <leader><CR> :call RunPython("cellstay")<cr>
    " run full script and show execution time
    autocmd FileType python nnoremap <buffer> <F5> :call RunPython("all")<cr>
augroup end

augroup jupyterfunctionkeyshortcuts
    autocmd!
    " run cell and jump to next cell (use '##' to mark a cell)
    autocmd FileType ipynb nnoremap <buffer> <CR> :call RunPython("celljump")<cr>
    " run cell and stay (use '##' to mark a cell)
    autocmd FileType ipynb nnoremap <buffer> <leader><CR> :call RunPython("cellstay")<cr>
augroup end

augroup latexfunctionkeyshortcuts
    autocmd!
    " build latex document
    autocmd FileType tex nnoremap <buffer> <F5> :call LatexBuild("")<CR>
    autocmd FileType tex nnoremap <buffer> <F5><F5> :call LatexBuild("-f")<CR>
augroup end

augroup markdownfunctionkeyshortcuts
    autocmd!
    if fnamemodify(expand('%'), ':p:h') != expand('~/VimWiki')
        " autocmd FileType markdown nnoremap <buffer> <CR> :call RunPython("cellstay")<cr>
    endif
augroup end

function! RunPython(type)
    if exists("g:last_terminal_job_id")
        let b:slime_config = [g:last_terminal_job_id]
        if (a:type == "celljump")
            IPythonCellExecuteCellJump
        elseif (a:type == "cellstay")
            IPythonCellExecuteCell
        elseif (a:type == "all")
            IPythonCellRunTime
        endif
    else
        call NewHorizontalTerminal("ipython --matplotlib")
        if exists("g:last_terminal_job_id")
            sleep 1
            call RunPython(a:type)
        endif
    endif
endfunction

function! LatexBuild(force)
    let latexcmd = "latexmk -xelatex -cd -synctex=1 -shell-escape ".a:force
    silent only
    if exists("$TEXBASE")
        let latexcmd = latexcmd.' "'.$TEXBASE.'"'
    else
        let latexcmd = latexcmd.' "'.expand('%:t:r').'"'
    endif
    echo latexcmd
    call NewHorizontalTerminal(latexcmd)
    sleep 100m
    execute "normal G\<C-w>k"
endfunction


"" SMDV Settings
"-------------------------------------------------------------------------------

let g:last_neovim_buffername = expand('%:p')
function! SmdvPutBufferName()
    if g:last_neovim_buffername != expand('%:p')
        let g:last_neovim_buffername = expand('%:p')
        let content = '{"filename": "'.g:last_neovim_buffername.'"}'
        let pid = jobstart("curl -X PUT -T - localhost:9876")
        call chansend(pid, content)
        call chanclose(pid, 'stdin')
    endif
endfunction
function! SmdvPutBufferContent()
    let lines = getline(1, '$')
    let row_num = max([0, line(".") - 1])
    let lines[row_num] = join([lines[row_num], '\n<span id="marker"></span>'], ' ')
    let content = join(lines, "\n")
    let pid = jobstart("curl -X PUT -T - localhost:9876")
    call chansend(pid, content)
    call chanclose(pid, 'stdin')
endfunction
function! StopSmdv()
    call jobstart("curl -X DELETE localhost:9876")
endfunction
function! StartSmdv()
    call jobstart("smdv ".expand('%:p')." --nvim-address ".v:servername." &> /home/flaport/smdv.log")
    augroup startsmdv
        autocmd!
        autocmd BufEnter * call SmdvPutBufferName()
        autocmd FileType markdown,vimwiki autocmd TextChanged,TextChangedI <buffer> call SmdvPutBufferContent()
    augroup end
endfunction
command! Smdv call StartSmdv()
command! SmdvStop call StopSmdv()
