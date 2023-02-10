"" Python Settings
"-------------------------------------------------------------------------------

augroup pythonsettings
    autocmd!

    " disable both hard wrapping and soft wrapping
    autocmd Filetype python NoWrap

    " also show colorcolumn at 88 characters
    autocmd Filetype python setlocal colorcolumn=88

    " enable autoindent on new line
    autocmd FileType python setlocal autoindent

    " set tabs to have a width of 4 spaces
    autocmd FileType python setlocal tabstop=4

    " set tabs to have a maximum width of 4 spaces
    autocmd FileType python setlocal softtabstop=4

    " set the shift operators (`<<` and `>>`) to insert 4 spaces
    autocmd FileType python setlocal shiftwidth=4
augroup end

