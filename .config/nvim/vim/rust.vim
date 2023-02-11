"" Rust Settings
"-------------------------------------------------------------------------------

augroup rustsettings
    autocmd!

    " disable both hard wrapping and soft wrapping
    autocmd Filetype rust NoWrap

    " also show colorcolumn at 88 characters
    autocmd Filetype rust setlocal colorcolumn=101

    " enable autoindent on new line
    autocmd FileType rust setlocal autoindent

    " set tabs to have a width of 4 spaces
    autocmd FileType rust setlocal tabstop=4

    " set tabs to have a maximum width of 4 spaces
    autocmd FileType rust setlocal softtabstop=4

    " set the shift operators (`<<` and `>>`) to insert 4 spaces
    autocmd FileType rust setlocal shiftwidth=4
augroup end

" lua require('rust-tools').inlay_hints.set()
