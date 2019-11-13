"    _____ _     ____  ____  ____  ____  _____ 
"   /    // \   /  _ \/  __\/  _ \/  __\/__ __\
"   |  __\| |   | / \||  \/|| / \||  \/|  / \  
"   | |   | |_/\| |-|||  __/| \_/||    /  | |  
"   \_/   \____/\_/ \|\_/   \____/\_/\_\  \_/  
"

"" Plugin installer
"-------------------------------------------------------------------------------

" From https://github.com/fisadev/fisa-nvim-config/blob/master/init.vim

let vim_plug_just_installed = 0
let vim_plug_path = expand('~/.config/nvim/autoload/plug.vim')
if !filereadable(vim_plug_path)
    echo "Installing Vim-plug..."
    echo ""
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
Plug 'tpope/vim-fugitive' " git support
Plug 'tpope/vim-repeat' " better repeating of last command
Plug 'tpope/vim-surround' " Surround word with character
Plug 'tpope/vim-markdown' " markdown syntax highlighting
Plug 'junegunn/fzf.vim' " fuzzy file search (needs fzf installed)
Plug 'junegunn/goyo.vim' " distraction free writing
Plug 'Shougo/context_filetype.vim' " Completion from other opened files
Plug 'Shougo/deoplete.nvim' " Async autocompletion
Plug 'davidhalter/jedi-vim' " Python go-to-definition [autocompletion disabled]
Plug 'zchee/deoplete-jedi'  " Python autocompletion
Plug 'mileszs/ack.vim' " Ack code search (needs ack installed)
Plug 'lilydjwg/colorizer' " Paint css colors with the real color
Plug 'valloric/MatchTagAlways' " Highlight matching html tags
Plug 'mattn/emmet-vim' " Generate html in a simple way
Plug 'mhinz/vim-signify' " Git/mercurial/others diff icons on the side of the file lines
Plug 'vim-scripts/YankRing.vim' " Yank history navigation
Plug 'neomake/neomake' " Linters
Plug 'sirver/ultisnips' " snippets
Plug 'honza/vim-snippets' " snippets
" Plug 'kien/rainbow_parentheses.vim' " different color paranthesis depending on nesting
" Plug 'powerline/powerline'
" Plug 'vim-airline/vim-airline'
Plug 'suan/vim-instant-markdown', {'for': 'markdown'}
call plug#end() " stop loading plugins


"" Install Plugins
"-------------------------------------------------------------------------------

if vim_plug_just_installed
    echo "Installing Bundles, please ignore key map error messages"
    :PlugInstall
endif


"" Plugin Settings
"-------------------------------------------------------------------------------

" Neomake ----------------------------------------------------------------------
" run linter on write
autocmd! BufWritePost * Neomake
" check code as python3 by default
let g:neomake_python_python_maker = neomake#makers#ft#python#python()
" use flake8 to check python code
let g:neomake_python_flake8_maker = neomake#makers#ft#python#flake8()

" Fzf --------------------------------------------------------------------------
" general code finder in current file mapping
nmap <Leader>f :BLines<CR>
" general code finder in all files mapping
nmap <Leader>F :Lines<CR>
" file finder mapping
nmap <Leader>e :Files<CR>
" tags (symbols) in current file finder mapping
nmap <Leader>g :BTag<CR>
" tags (symbols) in all files finder mapping
nmap <Leader>G :Tag<CR>
" commands finder mapping
nmap <Leader>c :Commands<CR>

" Jedi-vim ---------------------------------------------------------------------
" disable autocompletion (using deoplete instead)
let g:jedi#completions_enabled = 0
" all these mappings work only for python code:
" go to definition
let g:jedi#goto_command = '<Leader>d'
" find ocurrences
let g:jedi#usages_command = '<Leader>o'
" find assignments
let g:jedi#goto_assignments_command = '<Leader>a'

" Deoplete ---------------------------------------------------------------------
" enable deoplete
let g:deoplete#enable_at_startup = 1
" ignore case when code completing with lower case letters
let g:deoplete#enable_ignore_case = 1
" do not ignore case when code completing with upper case letters
let g:deoplete#enable_smart_case = 1
" complete with words from any opened file
let g:context_filetype#same_filetypes = {}
" set underscore
let g:context_filetype#same_filetypes._ = '_'

" Ack.vim ----------------------------------------------------------------------
" smart search and replace
nmap <Leader>r :Ack 
" smart word search and replace
nmap <Leader>wr :Ack <cword><CR>

" Autoclose --------------------------------------------------------------------
" fix to let ESC work as espected with Autoclose plugin
" (without this, when showing an autocompletion window, ESC won't leave insert mode)
let g:AutoClosePumvisible = {"ENTER": "\<C-Y>", "ESC": "\<Esc>"}

" Yankring -------------------------------
" fix for yankring and neovim problem when system has non-text copied in clipboard
let g:yankring_clipboard_monitor = 0
" set directory where yankring can be stored.
let g:yankring_history_dir = '~/.config/nvim/'

" Relative numbers -----------------------
let g:numbers_exclude = ["goyo"]

" Goyo -----------------------------------
nnoremap <C-x> :Goyo!<cr>:set tw=0<cr>
nnoremap <CR> :Goyo<cr>:set tw=70<cr>
let g:goyo_linenr = 0
let g:goyo_height = "75%"
let g:goyo_width = 80

" Ultisnips ------------------------------
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-.>"
let g:UltiSnipsJumpBackwardTrigger="<c-,>"

" Instant markdown -----------------------
let g:instant_markdown_port = 9876
let g:instant_markdown_autostart = 0
let g:instant_markdown_autoscroll = 1
let g:instant_markdown_python = 0
