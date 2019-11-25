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
Plug 'christoomey/vim-tmux-navigator' " tmux navigation
Plug 'tpope/vim-markdown' " markdown syntax highlighting
Plug 'suan/vim-instant-markdown', {'for': 'markdown'}
Plug 'davidhalter/jedi-vim' " Python go-to-definition [autocompletion disabled]
Plug 'Shougo/deoplete.nvim' " Async autocompletion
Plug 'zchee/deoplete-jedi'  " Python autocompletion
Plug 'Shougo/context_filetype.vim' " Completion from other opened files
Plug 'lilydjwg/colorizer' " Paint css colors with the real color
Plug 'valloric/MatchTagAlways' " Highlight matching html tags
Plug 'vim-scripts/YankRing.vim' " Yank history navigation
Plug 'neomake/neomake' " Linters
Plug 'mhinz/vim-signify' " Git/mercurial/others diff icons on the side of the file lines
Plug 'wikitopian/hardmode' " Vim hard mode (useful for training)
call plug#end() " stop loading plugins


"" Install Plugins
"-------------------------------------------------------------------------------

if vim_plug_just_installed
    echo "Installing Bundles, please ignore key map error messages"
    :PlugInstall
    :UpdateRemotePlugins
endif


"" Plugin Settings
"-------------------------------------------------------------------------------

" Markdown -------------------------------
" inline code highlighting
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh']
" conceal markdown syntax
let g:markdown_syntax_conceal = 1
" highlight 100 lines
let g:markdown_minlines = 100

" Neomake --------------------------------
" run linter on write
autocmd! BufWritePost * Neomake
" check code as python3 by default
let g:neomake_python_python_maker = neomake#makers#ft#python#python()
" use flake8 to check python code
let g:neomake_python_flake8_maker = neomake#makers#ft#python#flake8()

" Jedi-vim -------------------------------
" disable autocompletion (using deoplete instead)
let g:jedi#completions_enabled = 0
" all these mappings work only for python code:
" go to definition
let g:jedi#goto_command = '<Leader>d'
" find ocurrences
let g:jedi#usages_command = '<Leader>o'
" find assignments
let g:jedi#goto_assignments_command = '<Leader>a'

" Deoplete -------------------------------
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

" Ack.vim --------------------------------
" smart search and replace
nmap <Leader>r :Ack 
" smart word search and replace
nmap <Leader>wr :Ack <cword><CR>

" Autoclose ------------------------------
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

" Colorizer ------------------------------
let g:colorizer_maxlines = 1000

" Ultisnips ------------------------------
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-.>"
let g:UltiSnipsJumpBackwardTrigger="<c-,>"

" Instant markdown -----------------------
let g:instant_markdown_port = 9876
let g:instant_markdown_autostart = 0
let g:instant_markdown_autoscroll = 1
let g:instant_markdown_python = 0

" Vim signify ----------------------------
nnoremap <leader>g :SignifyToggle<CR>
let g:signify_disable_by_default = 1

