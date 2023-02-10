let g:vimwiki_list = [
    \ {
    \    'path': expand('~/VimWiki/'),
    \    'template_path': expand('~/VimWiki/templates'),
    \    'template_default': 'default',
    \    'syntax': 'markdown',
    \    'ext': '.md',
    \    'path_html': expand('~/VimWiki/html'),
    \    'custom_wiki2html': 'vimwiki_markdown',
    \    'template_ext': '.tpl'
    \ }
\ ]

function! EnterEmptyVimWikiDiaryFile()
    for config in g:vimwiki_list
        if fnamemodify(expand('%'), ':p:h') == fnamemodify(expand(config.path), ':p:h').'/diary'
            let date = '# '.expand('%:t:r')
            normal gg
            put =date
            normal ggdd
        endif
    endfor
endfunction

function! SetVimWikiPath()
    let curdir=fnamemodify(expand('%'), ':p:h')
    for config in g:vimwiki_list
        let vimwiki=fnamemodify(expand(config.path), ':p:h')
        let diary=vimwiki.'/diary'
        if curdir == vimwiki || curdir == diary
            let &path=''.vimwiki.','.diary
        endif
    endfor
endfunction

augroup vimwikisettings
    autocmd!
    autocmd BufNewFile *.md call EnterEmptyVimWikiDiaryFile()
    autocmd BufEnter *.md call SetVimWikiPath()
augroup end

