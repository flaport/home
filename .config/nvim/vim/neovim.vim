"" Vim Settings
"-------------------------------------------------------------------------------

augroup vimsettings
    autocmd!

    " disable both hard wrapping and soft wrapping and don't show a colorcolumn
    autocmd Filetype vim NoWrap

    " more info in status bar:
    autocmd FileType vim setlocal showmode

    " set tabs to have a width of 4 spaces
    autocmd FileType vim setlocal tabstop=4

    " set tabs to have a maximum width of 4 spaces
    autocmd FileType vim setlocal softtabstop=4

    " set the shift operators (`<<` and `>>`) to insert 4 spaces
    autocmd FileType vim setlocal shiftwidth=4

augroup end
