"" Filetypes
"-------------------------------------------------------------------------------

" define custom filetypes
augroup filetypes
    autocmd!
    autocmd BufNewFile,BufEnter,BufRead * filetype on
    autocmd BufNewFile,BufEnter,BufRead * filetype plugin on
    autocmd BufNewFile,BufEnter,BufRead * filetype indent on
    autocmd BufNewFile,BufEnter,BufRead *.vim,*.vimrc,*vifmrc setlocal filetype=vim
    autocmd BufNewFile,BufEnter,BufRead *.ipynb setlocal filetype=ipynb
    autocmd BufNewFile,BufEnter,BufRead *.tex,*.sty setlocal filetype=tex
    autocmd BufNewFile,BufEnter,BufRead *.txt,/tmp/neomutt* setlocal filetype=text
    autocmd BufNewFile,BufEnter,BufRead *.md,/tmp/calcurse*,~/.calcurse/notes/* setlocal filetype=vimwiki
    autocmd BufNewFile,BufEnter,BufRead *.py setlocal filetype=python
    autocmd BufNewFile,BufEnter,BufRead *.rs setlocal filetype=rust
augroup end


"" Default Variable Settings
"-------------------------------------------------------------------------------
" these settings may change depending on the filetype or active extension

" enable no wrapping (disable both hard wrapping and soft wrapping)
set nowrap nolinebreak formatoptions=lqj textwidth=0 colorcolumn=0

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

" set tabs to have a width of 2 spaces
set tabstop=2

" set tabs to have a maximum width of 2 spaces
set softtabstop=2

" set the shift operators (`<<` and `>>`) to insert 2 spaces
set shiftwidth=2

"" Latex Settings
"-------------------------------------------------------------------------------

augroup latexmarkdownsettings
    autocmd!

    " enable hard wrapping (insert enter) at 88 characters [tex, md, vimwiki]
    autocmd Filetype tex,markdown,vimwiki HardWrap

    " enable soft wrapping (no enter inserted) at end of window [text files]
    autocmd Filetype text SoftWrap

    " when using soft wrapping, you'll likely want to remap j and k:
    autocmd FileType text nnoremap <buffer> j gj
    autocmd FileType text nnoremap <buffer> k gk

    " don't show line numbers
    autocmd FileType tex,text,markdown,vimwiki setlocal nonumber

    " don't show relative line numbering
    autocmd FileType tex,text,markdown,vimwiki setlocal norelativenumber

    " spell check, set default to en_us
    autocmd FileType tex,text,markdown,vimwiki setlocal spell

    " left margin width (max 12)
    autocmd FileType tex,text,markdown,vimwiki setlocal foldcolumn=8

    " show where you are in the document in status bar (e.g. 143,61, 20%)
    autocmd FileType tex,text,markdown,vimwiki setlocal noruler

    " show status bar (0=disabled, 1=show half status bar, 2=show full status bar)
    autocmd FileType tex,text,markdown,vimwiki setlocal laststatus=0

    " don't show last command executed
    autocmd FileType tex,text,markdown,vimwiki setlocal noshowcmd
augroup end

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

augroup yamlsettings
    autocmd!

    " enable indentLine plugin
    let g:indentLine_enabled = 1
augroup end
