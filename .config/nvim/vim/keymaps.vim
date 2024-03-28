" more information (toggle status bar)
nnoremap <leader>I :call ToggleStatusBar()<CR>
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

" toggle relative line numbers
nnoremap <leader>l :call RelativeNumberToggle()<CR>
function! RelativeNumberToggle()
    if (&relativenumber == 1)
        setlocal norelativenumber
    else
        setlocal relativenumber
    endif
    setlocal nonumber
endfunc

" toggle absolute line numbers
nnoremap <leader>L :call AbsoluteNumberToggle()<CR>
function! AbsoluteNumberToggle()
    if (&number == 1)
        setlocal nonumber
    else
        setlocal number
    endif
    setlocal norelativenumber
endfunc

" paste from clipboard in stead of selection
nnoremap <leader>p :call Paste()<CR>
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
