
"" Plugin Settings
"-------------------------------------------------------------------------------
" Plugin settings are defined here. Keyboard shortcuts are defined in init.vim.


" davidhalter/jedi-vim ---------------------------------------------------------

" disable autocompletion (using coc-pyright instead)
let g:jedi#completions_enabled = 0
" disable call signatures (using coc-pyright instead)
let g:jedi#show_call_signatures = 0
" all these mappings work only for python code:
" go to definition
let g:jedi#goto_command = '<Leader>d'
" find ocurrences
let g:jedi#usages_command = '<Leader>o'
" find assignments
let g:jedi#goto_assignments_command = '<Leader>a'


" hanschen/vim-ipython-cell ----------------------

let g:ipython_cell_tag = ['##+', '```', '```python', '```py']
let g:ipython_cell_regex=1


" jpalardy/vim-slime -----------------------------

let g:slime_no_mappings = 1
let g:slime_target = "neovim"
let g:slime_python_ipython = 1
let g:slime_dont_ask_default = 1
let g:slime_cell_delimiter = "##"
let g:slime_paste_file = "~/.config/nvim/slime_paste" " don't use $HOME here...
let g:slime_default_config = [5]


" jremmen/vim-ripgrep ----------------------------

" only use ripgrep if it is available
if executable('rg')
    set grepprg=rg\ --vimgrep
    set grepformat=%f:%l:%c:%m
    let g:rg_derive_root='true'
endif


" junegunn/fzf.vim -------------------------------

let g:fzf_layout = {
    \ 'window' : {
        \ 'width': 0.8,
        \ 'height': 0.6,
        \ 'highlight': 'Comment'
    \}
\}


" lilydjwg/colorizer -----------------------------

" do not color more than 100 lines at once
let g:colorizer_maxlines = 100


" mhinz/vim-signify ------------------------------

" disable vim signify by default...
let g:signify_disable_by_default = 1


" neoclide/coc.nvim ------------------------------
" jump to CoC settings file from anywhere: <leader>coc
" jump to CoC settings json file from anywhere: <leader>coj

if filereadable(expand("~/.config/nvim/coc-settings.vim"))
    source ~/.config/nvim/coc-settings.vim
endif


" shougo/context_filetype.vim --------------------

" complete with words from any opened file
let g:context_filetype#same_filetypes = {}

" set underscore
let g:context_filetype#same_filetypes._ = '_'


" spolu/dwm.vim ----------------------------------

" don't automatically map the keys (we do this ourselves in init.vim)
let g:dwm_map_keys = 0


" suan/vim-instant-markdown-----------------------

" always run on port 9876
let g:instant_markdown_port = 9876
" do not start when opening markdown file
let g:instant_markdown_autostart = 0
" obviously, enable markdown autoscroll
let g:instant_markdown_autoscroll = 1
" don't use the python server (requires npm package: `npm -g install instant-markdown-d`)
let g:instant_markdown_python = 1
" use custom webapp script to open browser:
let g:instant_markdown_browser = "firefox"


" tpope/vim-markdown -----------------------------

" inline code highlighting
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh']
" conceal markdown syntax
let g:markdown_syntax_conceal = 1
" highlight 100 lines
let g:markdown_minlines = 100

" vimwiki/vimwiki --------------------------------

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
