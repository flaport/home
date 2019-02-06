" PLUGIN INSTALLER
" ================
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


" LOAD PLUGINS
" ============
" Run :PlugInstall to install extra packages after adding them to the list below
" Run :UpdateRemotePlugins to update dependencies
call plug#begin('~/.config/nvim/plugged') " start loading plugins
Plug 'tpope/vim-fugitive' " git support
Plug 'tpope/vim-repeat' " better repeating of last command
Plug 'tpope/vim-surround' " Surround word with character
Plug 'junegunn/fzf.vim' " fuzzy file search (needs fzf installed)
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
Plug 'myusuf3/numbers.vim' " Relative numbering of lines (0 is the current line)
call plug#end() " stop loading plugins

" INSTALL PLUGINS
" ===============
if vim_plug_just_installed
    echo "Installing Bundles, please ignore key map error messages"
    :PlugInstall
endif

" PLUGIN SETTINGS
" ===============

" Neomake ------------------------------
" Run linter on write
autocmd! BufWritePost * Neomake
" Check code as python3 by default
let g:neomake_python_python_maker = neomake#makers#ft#python#python()
let g:neomake_python_flake8_maker = neomake#makers#ft#python#flake8()

" Fzf ------------------------------
" file finder mapping
nmap <Leader>e :Files<CR>
" tags (symbols) in current file finder mapping
nmap <Leader>g :BTag<CR>
" tags (symbols) in all files finder mapping
nmap <Leader>G :Tag<CR>
" general code finder in current file mapping
nmap <Leader>f :BLines<CR>
" general code finder in all files mapping
nmap <Leader>F :Lines<CR>
" commands finder mapping
nmap <Leader>c :Commands<CR>

" Jedi-vim ------------------------------
" Disable autocompletion (using deoplete instead)
let g:jedi#completions_enabled = 0

" All these mappings work only for python code:
" Go to definition
let g:jedi#goto_command = '<Leader>d'
" Find ocurrences
let g:jedi#usages_command = '<Leader>o'
" Find assignments
let g:jedi#goto_assignments_command = '<Leader>a'
" Go to definition in new tab
nmap <Leader>D :tab split<CR>:call jedi#goto()<CR>

" Deoplete -----------------------------
" enable deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_ignore_case = 1
let g:deoplete#enable_smart_case = 1
" complete with words from any opened file
let g:context_filetype#same_filetypes = {}
let g:context_filetype#same_filetypes._ = '_'


" Ack.vim ------------------------------
" mappings
nmap <Leader>r :Ack 
nmap <Leader>wr :Ack <cword><CR>

" Autoclose ------------------------------
" Fix to let ESC work as espected with Autoclose plugin
" (without this, when showing an autocompletion window, ESC won't leave insert
"  mode)
let g:AutoClosePumvisible = {"ENTER": "\<C-Y>", "ESC": "\<Esc>"}

" Yankring -------------------------------
" Fix for yankring and neovim problem when system has non-text things copied
" in clipboard
let g:yankring_clipboard_monitor = 0
let g:yankring_history_dir = '~/.config/nvim/'

