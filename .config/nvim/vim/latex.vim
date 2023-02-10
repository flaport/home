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

