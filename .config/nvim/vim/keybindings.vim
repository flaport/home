"" Fixed Keyboard Shortcuts
"-------------------------------------------------------------------------------
" these keyboard shortcuts won't change, no matter the filetype or active extension

" back to normal mode (just use escape, man...)
" inoremap jj <Esc>

" go to edit mode in terminal emulator:
" the backtick is there to not interfere with the <Esc> of the shell itself.
tnoremap <Esc> <C-\><C-n>
" keep original Escape available uner `<Esc>
tnoremap `<Esc> <Esc>

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
endfunction

" close current buffer
inoremap <C-c> <Esc>:call CloseBuffer()<CR>
nnoremap <C-c> <Esc>:call CloseBuffer()<CR>

" down half screen
" <C-d> " standard vim keybinding

" scroll text up with cursor staying where it is (opposite of <C-y>)
" <C-e> " standard vim keybinding

" exit terminal mode
tnoremap <C-e> <C-\><C-N>

" down full screen
" <C-f> " standard vim keybinding

" show status
" <C-g> " standard vim keybinding


" increase master area (requires dwm.vim)
" nmap <C-h> <Plug>DWMShrinkMaster
" move to split left of current split (also when in terminal mode)
nnoremap <C-h> <C-w>h
tnoremap <C-h> <C-\><C-N><C-w>h

" DISABLED: jump forward in cursor position stack (same as TAB; opposite of <C-o>)
" <C-i> = TAB " standard vim keybinding

" move to next split in clockwise direction (requires dwm.vim)
" nmap <C-j> <C-w>w
" move to split below of current split (also when in terminal mode)
nnoremap <C-j> <C-w>j
tnoremap <C-j> <C-\><C-N><C-w>j

" move to previous split in anticlockwise direction (requires dwm.vim)
" nmap <C-k> <C-w>W
" move to split above of current split (also when in terminal mode)
nnoremap <C-k> <C-w>k
tnoremap <C-k> <C-\><C-N><C-w>k

" decrease master area (requires dwm.vim)
" nmap <C-l> <Plug>DWMGrowMaster
" move to split right of current split (also when in terminal mode)
nnoremap <C-l> <C-w>l
tnoremap <C-l> <C-\><C-N><C-w>l

" move to first non-whitespace of next line
" <C-m> " standard vim keybinding

" create new split in master area (requires dwm.vim)
" nmap <C-n> <Plug>DWMNew

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
nnoremap <leader>ci :e ~/.config/nvim/init.vim<CR>
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

" jump to next error / warning in file
nnoremap <leader>e :call CocAction('diagnosticNext')<CR>

" jump to previous error / warning in file
nnoremap <leader>E :call CocAction('diagnosticPrevious')<CR>

" fuzzy find content in all files in tree  (requires junegunn/fzf)
nnoremap <leader>fb :Buffers<CR>
nnoremap <leader>fc :Commands<CR>
nnoremap <leader>ff :Files<CR>
nnoremap <leader>fl :Lines<CR>
nnoremap <leader>fL :BLines<CR>
nnoremap <leader>fm :Marks<CR>
nnoremap <leader>fM :Maps<CR>
nnoremap <leader>ft :Tags<CR>
nnoremap <leader>fi :CocCommand python.sortImports<CR>

" autoformat code (requires neoclide/coc.nvim)
xmap <leader>F <Plug>(coc-format-selected)
nmap <leader>F :Autoformat<CR>

" Toggle (git) diff bar (requires tpope/vim-fugitive and mhinz/vim-signify)
" in 's' to stage, 'u' to unstage
nnoremap <leader>gg :Git<CR>
nnoremap <leader>gs :Git<CR>
nnoremap <leader>gc :Gcommit<CR>
nnoremap <leader>gp :Gpush<CR>
nnoremap <leader>gv :Gvdiffsplit!<CR><C-w>L<C-w>h<C-w>L<C-w>h
nnoremap <leader>gu :diffget //2<CR>
nnoremap <leader>gh :diffget //3<CR>
nnoremap <leader>gt :SignifyToggle<CR>

" go to definition and similar (requires neoclide/coc.nvim)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Toggle Goyo
nnoremap <leader>G :Goyo<CR>

" shrink current horizontal split (decrease height)
nnoremap <leader>h 3<C-w>-

" make all splits horizontal
nnoremap <leader>H <C-w>t<C-w>K

" enable hard mode for training purposes (requires wikitopian/hardmode)
"nnoremap <leader>H <Esc>:call ToggleHardMode()<CR>

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

" shrink current vertical split (decrease width)
nnoremap <leader>v 3<C-w><

" make all splits vertical
nnoremap <leader>V <C-w>t<C-w>H

" enable no wrapping
nnoremap <leader>wn :NoWrap<cr>

" enable soft wrapping
nnoremap <leader>ws :SoftWrap<cr>

" enable hard wrapping
nnoremap <leader>wh :HardWrap<cr>

" noop
nnoremap <leader>W :echo "\<leader\>W"<cr>

" noop
nnoremap <leader>x :echo "\<leader\>x"<cr>
nnoremap <leader>X :echo "\<leader\>X"<cr>

" noop
nnoremap <leader>y :echo "\<leader\>y"<cr>
nnoremap <leader>Y :echo "\<leader\>Y"<cr>

" focus current split in master area (requires dwm.vim)
" nmap <C-space> <Plug>DWMFocus

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
    autocmd FileType python nnoremap <buffer> <S-CR> :call RunPython("celljump")<cr>
    " run cell and stay (use '##' to mark a cell)
    autocmd FileType python nnoremap <buffer> <C-CR> :call RunPython("cellstay")<cr>
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
        call system('ipython -c "import sys"')
        if !v:shell_error
            call NewHorizontalTerminal("ipython")
            if exists("g:last_terminal_job_id")
                sleep 300m
                call RunPython(a:type)
            endif
        else
            echo "ipython not found"
        endif
    endif
endfunction

function! LatexBuild(force)
    delmarks m
    normal mm
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
    normal `m
    delmarks m
endfunction


