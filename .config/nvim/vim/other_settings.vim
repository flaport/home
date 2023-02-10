"" Other Keyboard Shortcuts
"-------------------------------------------------------------------------------
" these keyboard shortcuts won't change, no matter the filetype or active extension

" back to normal mode (just use escape, man...)
" inoremap jj <Esc>

" Y to yank the whole line
nmap Y yy

" go to edit mode in terminal emulator:
" the backtick is there to not interfere with the <Esc> of the shell itself.
tnoremap <Esc> <C-\><C-n>
" keep original Escape available uner `<Esc>
tnoremap `<Esc> <Esc>


" remap 'n' and 'N' to center screen after jumping to next match
nnoremap n nzz
nnoremap N Nzz


" go to next misspelled word (enable spell checker with F2)
" ]s " standard vim keybinding

" go to previous misspelled word (enable spell checker with F2)
" [s " standard vim keybinding

" show suggestion for misspelled word (enable spell checker with F2)
" z= " standard vim keybinding

" add a word to the dictionary (enable spell checker with F2)
" zg " standard vim keybinding

" remove word from dictionary (enable spell checker with F2)
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

" edit one of the vim config files (requires set hidden)
nnoremap <leader>ci :e ~/.config/nvim/init_nvim.vim<CR>
nnoremap <leader>cp :e ~/.config/nvim/plugins.vim<CR>
nnoremap <leader>lp :e ~/.config/nvim/lua/plugins.lua<CR>
nnoremap <leader>cs :e ~/.config/nvim/snippets/snippets.vim<CR>
nnoremap <leader>coc :e ~/.config/nvim/coc-settings.vim<CR>
nnoremap <leader>coj :e ~/.config/nvim/coc-settings.json<CR>

" cd into folder containing current file
nnoremap <leader>cd :lcd %:p:h<CR>

" noop
nnoremap <leader>C :echo "\<leader\>C"<cr>


" noop
nnoremap <leader>D :echo "\<leader\>D"<cr>


" fuzzy find content in all files in tree  (requires junegunn/fzf)
" nnoremap <leader>fb :Buffers<CR>
" nnoremap <leader>fc :Commands<CR>
" nnoremap <leader>ff :Files<CR>
" nnoremap <leader>fl :Lines<CR>
" nnoremap <leader>fL :BLines<CR>
" nnoremap <leader>fm :Marks<CR>
" nnoremap <leader>fM :Maps<CR>
" nnoremap <leader>ft :Tags<CR>


" Toggle (git) diff bar (requires tpope/vim-fugitive and mhinz/vim-signify)
" in 's' to stage, 'u' to unstage
nnoremap <leader>gg :Git<CR>
nnoremap <leader>gs :Git<CR>
nnoremap <leader>gc :Gcommit<CR>
nnoremap <leader>gp :Gpush<CR>
nnoremap <leader>gv :Gvdiffsplit!<CR><C-w>L<C-w>h<C-w>L<C-w>h
nnoremap <leader>gu :diffget //1<CR>
nnoremap <leader>gh :diffget //2<CR>
nnoremap <leader>gt :SignifyToggle<CR>


" Toggle Goyo
nnoremap <leader>G :Goyo<CR>

" enable hard mode for training purposes (requires wikitopian/hardmode)
" nnoremap <leader>h <Esc>:call HardTimeToggle()<CR>

" shrink current horizontal split (decrease height)
nnoremap <leader>h 2<C-w>-

" make all splits horizontal
nnoremap <leader>H <C-w>t<C-w>K

" enable hard mode for training purposes (requires wikitopian/hardmode)
"nnoremap <leader>H <Esc>:call ToggleHardMode()<CR>

"<leader>i: more information (toggle status bar)
" nnoremap <leader>i :call ToggleStatusBar()<CR>

" noop
nnoremap <leader>I :echo "\<leader\>I"<cr>

" noop
nnoremap <leader>j :echo "\<leader\>j"<cr>


" noop
nnoremap <leader>k :echo "\<leader\>k"<cr>


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


" noop
" nnoremap <leader>q :echo "\<leader\>q"<cr>
nnoremap <leader>Q :echo "\<leader\>Q"<cr>


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
" nnoremap <leader>u :UndotreeShow<CR><C-w>h

" noop
nnoremap <leader>U :echo "\<leader\>U"<cr>

" shrink current vertical split (decrease width)
nnoremap <leader>v 2<C-w><

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

    " " black python formatting for visual selection
    " autocmd FileType python xmap <buffer> <leader>F :!black - 1>/dev/null<CR>

    " go to definition (python only) -- inherited from plugins
    " <leader>d
augroup end

augroup latexleadershortcuts
    autocmd!

    autocmd FileType tex nnoremap <buffer> <leader>s :call SyncTex()<CR>
    "FYI: Ctrl-Click  --> latex synctex zathura pdf->tex
augroup end

function! ToggleStatusBar()
    if (&laststatus == 1)
        setlocal noshowmode
        setlocal noruler
        setlocal laststatus=-1
        setlocal noshowcmd
    else
        setlocal showmode
        setlocal ruler
        setlocal laststatus=1
        setlocal showcmd
    endif
endfunction

function! RelativeNumberToggle()
    if (&relativenumber == 0)
        setlocal norelativenumber
    else
        setlocal relativenumber
    endif
    setlocal nonumber
endfunc

function! AbsoluteNumberToggle()
    if (&number == 0)
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


" Coc Keymaps

" " use K to show documentation in preview window (reqruires neoclide/coc.nvim)
" nnoremap <silent> K :call ShowDocumentation()<CR>

" " Use `[g` and `]g` to navigate diagnostics (requires neoclide/coc.nvim)
" nmap <silent> [g <Plug>(coc-diagnostic-prev)
" nmap <silent> ]g <Plug>(coc-diagnostic-next)

" " Show all diagnostics (requires neoclide/coc.nvim)
" nnoremap <silent> <leader>q  :<C-u>CocList diagnostics<cr>

" " Manage CoC extensions (requires neoclide/coc.nvim)
" nnoremap <silent> <leader>ce  :<C-u>CocList extensions<cr>

" " Show CoC commands (requires neoclide/coc.nvim)
" nnoremap <silent> <leader>cm  :<C-u>CocList commands<cr>

" " Find symbol of current document (requires neoclide/coc.nvim)
" nnoremap <silent> <leader>co  :<C-u>CocList outline<cr>

" " Search workspace symbols (requires neoclide/coc.nvim)
" " nnoremap <silent> <leader>ci  :<C-u>CocList -I symbols<cr>

" " " jump to next error / warning in file
" " nnoremap <leader>e :call CocAction('diagnosticNext')<CR>

" " jump to previous error / warning in file
" nnoremap <leader>E :call CocAction('diagnosticPrevious')<CR>

" " Python sort imports
" nnoremap <leader>fi :CocCommand python.sortImports<CR>

" " autoformat code (requires neoclide/coc.nvim)
" " xmap <leader>F <Plug>(coc-format-selected)
" " nmap <leader>F :LSPFormat<CR>
" nmap <leader>F :Format<CR>

" " go to definition and similar (requires neoclide/coc.nvim)
" nmap <silent> gd <Plug>(coc-definition)
" nmap <silent> gy <Plug>(coc-type-definition)
" nmap <silent> gi <Plug>(coc-implementation)
" nmap <silent> gr <Plug>(coc-references)

" " Applying codeAction
" nmap <nowait> <leader>a  <Plug>(coc-codeaction-cursor)
" " nmap <silent><nowait> <space>ac  <Plug>(coc-codeaction)

" " do default action for next item (requires neoclide/coc.nvim)
" nmap <leader>J  :<C-u>CocNext<CR>

" " do default action for previous item (requires neoclide/coc.nvim)
" nmap <leader>K  :<C-u>CocPrev<CR>

" " resume latest CoC list (requires neoclide/coc.nvim)
" nmap <leader>P  :<C-u>CocListResume<CR>

" " rename symbol (requires neoclide/coc.nvim)
" " nmap <leader>r <Plug>(coc-rename)
" " nnoremap <silent><nowait> <space>rn <Plug>(coc-rename)
" nmap <nowait> <leader>rn <Plug>(coc-rename)

" " Run the Code Lens action on the current line.
" nmap <nowait> <leader>cl <Plug>(coc-codelens-action)

" " go to definition (requires neoclide/coc.nvim)
" " nmap <silent> <leader>d :w<CR><Plug>(coc-definition)



"" Variable Function Key Shortcuts
"-------------------------------------------------------------------------------
" these settings may change depending on the filetype or active extension

" show vim help
" <F0> " standard vim keybinding

" noop
nnoremap <F1> :echo "\<F2\>"<cr>

" toggle spell checker:
nnoremap <F2> <Esc>:setlocal spell!<CR>
inoremap <F2> <Esc>:setlocal spell!<CR>

" choose spell checker language and enable
nnoremap <F2><F3> <Esc>:setlocal spell spelllang=
inoremap <F2><F3> <Esc>:setlocal spell spelllang=

" source init.vim again.
" function! Source_vim_lua()
"     exec "silent !test -z $TEXBASE && TEXBASE=%:p:r; zathura --synctex-editor-command 'nvr --servername ".v:servername." +\\%{line} \\%{input}' --synctex-forward ".line(".").":".col(".").":%:p $TEXBASE.pdf &"
" endfunction
nnoremap <F3> <Esc>:source ~/.config/nvim/init.vim<CR>:edit<CR>:luafile ~/.config/nvim/lua/pluginrc/init.lua<CR>
inoremap <F3> <Esc>:source ~/.config/nvim/init.vim<CR>:edit<CR>:luafile ~/.config/nvim/lua/pluginrc/init.lua<CR>

" " noop
" nnoremap <F4> :echo "\<F5\>"<cr>

" noop
nnoremap <F5> :echo "\<F6\>"<cr>

" noop
nnoremap <F6> :echo "\<F7\>"<cr>

" noop
nnoremap <F7> :echo "\<F8\>"<cr>

" noop
nnoremap <F8> :echo "\<F9\>"<cr>

" noop
nnoremap <F9> :echo "\<F10\>"<cr>

" noop
nnoremap <F10> :echo "\<F11\>"<cr>

" noop
nnoremap <F11> :echo "\<F12\>"<cr>

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
    autocmd FileType tex nnoremap <buffer> <F4> :call LatexBuild("")<CR>
    autocmd FileType tex nnoremap <buffer> <F4><F5> :call LatexBuild("-f")<CR>
augroup end

let g:slime_no_mappings = 0
let g:slime_target = "neovim"
let g:slime_python_ipython = 0
let g:slime_dont_ask_default = 0
let g:slime_cell_delimiter = "##"
" let g:slime_paste_file = "$HOME/.config/nvim/slime_paste"
let g:slime_default_config = [4]

let g:ipython_cell_tag = ['##%','##[+=\-*]' ,'```', '```python', '```py']
let g:ipython_cell_regex=0
let g:ipython_cell_highlight_cells=0

function! LatexBuild(force)
    delmarks m
    normal mm
    let latexcmd = "latexmk -xelatex -cd -synctex=0 -shell-escape ".a:force
    silent only
    if exists("$TEXBASE")
        let latexcmd = latexcmd.' "'.$TEXBASE.'"'
    else
        let latexcmd = latexcmd.' "'.expand('%:t:r').'"'
    endif
    echo latexcmd
    " call NewHorizontalTerminal(latexcmd)
    " sleep 99m
    " execute "normal G\<C-w>k"
    lua local lalacmd = vim.api.nvim_eval("latexcmd"); _MK_Latex(lalacmd)
    normal `m
    delmarks m
endfunction

