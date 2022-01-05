"    _____ _     ____  ____  ____  ____  _____
"   /    // \   /  _ \/  __\/  _ \/  __\/__ __\
"   |  __\| |   | / \||  \/|| / \||  \/|  / \
"   | |   | |_/\| |-|||  __/| \_/||    /  | |
"   \_/   \____/\_/ \|\_/   \____/\_/\_\  \_/
"
" jump to plugins file from anywhere: <leader>cp

"" Plugin installer
"-------------------------------------------------------------------------------

" enable different behavior for different filetypes:
set nocompatible
filetype on
filetype plugin on
filetype indent on

" From https://github.com/fisadev/fisa-nvim-config/blob/master/init.vim
let vim_plug_just_installed = 0
let vim_plug_path = expand('~/.config/nvim/autoload/plug.vim')
if !filereadable(vim_plug_path)
    echo "Installing Vim-plug...\n"
    silent !mkdir -p ~/.config/nvim/autoload
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    let vim_plug_just_installed = 1
endif

" manually load vim-plug the first time
if vim_plug_just_installed
    :execute 'source '.fnameescape(vim_plug_path)
endif


"" Plugins
"-------------------------------------------------------------------------------

" Run :PlugInstall to install extra packages after adding them to the list below
" Run :UpdateRemotePlugins to update dependencies

call plug#begin('~/.config/nvim/plugged') " start loading plugins
Plug 'anntzer/vim-cython' " cython syntax highlighting
Plug 'bling/vim-bufferline' " bufferline integration for airline
Plug 'cespare/vim-toml' " toml syntax highlighting
Plug 'davidhalter/jedi-vim' " Python go-to-definition [autocompletion disabled]
Plug 'glench/vim-jinja2-syntax' " jinja2 support in vim
Plug 'jpalardy/vim-slime' " better integration between text and terminal buffers
Plug 'junegunn/fzf.vim' " fuzzy file finder (needs system wide fzf install)
Plug 'junegunn/goyo.vim', " distraction free writing.
Plug 'kshenoy/vim-signature' " show marks in margin
Plug 'lilydjwg/colorizer' " paint css colors with the real color
Plug 'mattn/emmet-vim' " emmet for vim
Plug 'mbbill/undotree' " undo tree for vim
Plug 'mhinz/vim-signify' " git/mercurial/others diff icons on the side of the file lines
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'pedrohdz/vim-yaml-folds' " better folding for yaml files
Plug 'posva/vim-vue' " vuejs syntax highlighting
Plug 'shougo/context_filetype.vim' " completion from other opened files
Plug 'suan/vim-instant-markdown'
Plug 'tpope/vim-commentary' " easy comment
Plug 'tpope/vim-fugitive' " better git integration
Plug 'tpope/vim-repeat' " easily repeat plugin commands with .
Plug 'tpope/vim-speeddating' " increase date with <C-A>
Plug 'tpope/vim-surround' " easily surround word with quotes or tags
Plug 'valloric/MatchTagAlways' " highlight matching html tags
Plug 'vim-airline/vim-airline' " better status bar
Plug 'vim-utils/vim-man' " man pages in vim
Plug 'vimwiki/vimwiki' " note taking in vim
Plug 'wikitopian/hardmode' " vim hard mode (useful for training)
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " Better syntax highlighting

call system('ipython -c "import sys"')
if !v:shell_error
call system('which notedown')
    Plug 'hanschen/vim-ipython-cell' " better integration with ipython (requires slime)
endif

if !v:shell_error
    Plug 'szymonmaszke/vimpyter' " edit jupyter notebooks
endif
call plug#end() " stop loading plugins


"" Install Plugins
"-------------------------------------------------------------------------------

if vim_plug_just_installed
    echo "Installing Bundles, please ignore key map error messages"
    :PlugInstall
endif


"" Plugin Settings
"-------------------------------------------------------------------------------
" Plugin settings are defined here. Keyboard shortcuts are defined in init.vim.


" nvim-treesitter/nvim-treesitter ----------------------------------------------

lua <<EOF
require'nvim-treesitter.configs'.setup {
  -- One of "all", "maintained" (parsers with maintainers), or a list of languages
  ensure_installed = "maintained",

  -- Install languages synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- List of parsers to ignore installing
  ignore_install = { "vim" },

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- list of language that will be disabled
    disable = { "bash", "sh", "vim" },

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = { "bash", "sh", "vim" },
  },
  indent = { enable = true, disable = { "yaml" } },
}
EOF


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
let g:slime_paste_file = "$HOME/.config/nvim/slime_paste"
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


" vim-airline/vim-airline ------------------------

" enable powerline fonts for vim airline
let g:airline_powerline_fonts = 1
let g:airline_theme="xresources_airline"
let g:airline#extensions#bufferline#enabled = 1
let g:airline#extensions#bufferline#overwrite_variables = 1
let g:bufferline_echo = 0

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
