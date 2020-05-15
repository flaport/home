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
" Plug 'davidhalter/jedi-vim' " python go-to-definition (disabled in favor of CoC)
Plug 'jremmen/vim-ripgrep' " better grep command for vim
Plug 'junegunn/fzf.vim' " fuzzy file finder (needs system wide fzf install)
Plug 'junegunn/goyo.vim', " distraction free writing.
Plug 'ctrlpvim/ctrlp.vim' " alternative fuzzy file finder
Plug 'kshenoy/vim-signature' " show marks in margin
Plug 'lilydjwg/colorizer' " paint css colors with the real color
Plug 'mbbill/undotree' " undo tree for vim
Plug 'mhinz/vim-signify' " git/mercurial/others diff icons on the side of the file lines
" Plug 'neomake/neomake' " linters (disabled in favor of CoC)
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'psf/black' " black python plugin
Plug 'voldikss/vim-floaterm' " floating terminal
Plug 'Shougo/context_filetype.vim' " completion from other opened files
Plug 'suan/vim-instant-markdown', {'for': 'markdown'}
Plug 'tpope/vim-commentary' " easy comment
Plug 'tpope/vim-markdown' " markdown syntax highlighting
Plug 'tpope/vim-repeat' " easily repeat plugin commands with .
Plug 'tpope/vim-speeddating' " increase date with <C-A>
Plug 'tpope/vim-surround' " easily surround word with quotes or tags
Plug 'valloric/MatchTagAlways' " highlight matching html tags
Plug 'vim-airline/vim-airline' " better status bar
Plug 'vim-utils/vim-man' " man pages in vim
Plug 'wikitopian/hardmode' " vim hard mode (useful for training)
" Plug 'ycm-core/YouCompleteMe', { 'do': './install.py --all' } " vim autocomplete (disabled in favor of CoC)
call plug#end() " stop loading plugins



"" Install Plugins
"-------------------------------------------------------------------------------

if vim_plug_just_installed
    echo "Installing Bundles, please ignore key map error messages"
    :PlugInstall
endif


"" Plugin Settings
"-------------------------------------------------------------------------------

" davidhalter/jedi-vim ---------------------------
" default configuration of jedi-vim kinda sucks. A lot of settings mess with
" the default vim completion and make it work not like expected. The
" configuration below tries to disable those insensible defaults.
" let g:jedi#auto_initialization = 1 " initialize normally
" let g:jedi#completions_command = '' " just default omicompletion: <C-x><C-o>
" let g:jedi#smart_auto_mappings = 0 " this is incredibly annoying hence disabled
" let g:jedi#auto_vim_configuration = 0 " don't let the plugin mess with the default completion settings
" let g:jedi#popup_select_first = 0 " don't let the plugin mess with the default completion settings
" let g:jedi#show_call_signatures = 1 " show call signatures inline
" let g:jedi#squelch_py_warning = 1 " no warning when python not available
" let g:jedi#completions_enabled = 1 " enable python completions
" let g:jedi#goto_command = '' " goto python definition (disbled in favor of YCM)
" let g:jedi#rename_command = '' " rename python variable (disabled in favor of YCM)
" let g:jedi#usages_command = '' " '<leader>o'  find ocurrences (disabled)
" let g:jedi#documentation_command = 'K' " show python docstring
" let g:jedi#popup_on_dot = 0 " only after first letter
" let g:jedi#goto_assignments_command = '' " not used (partially covered by goto_command)
" let g:jedi#goto_definitions_command = '' " not used (partially covered by goto_command)

" jremmen/vim-ripgrep ----------------------------
" default settings when ripgrep is available
if executable('rg')
    set grepprg=rg\ --vimgrep
    set grepformat=%f:%l:%c:%m
    let g:rg_derive_root='true'
endif

" junegunn/fzf.vim -------------------------------
" general code finder in current file mapping
nnoremap <leader>/ :BLines<CR>
" general code finder in all files mapping
nnoremap <leader>ff :Lines<CR>
" fuzzy find in tags
nnoremap <leader>ft :Tag<CR>
" file finder mapping
nnoremap <leader>e :Files<CR>
" tags (symbols) in all files finder mapping
nnoremap <leader>t :Tag<CR>

" junegunn/goyo.vim -------------------------------
" toggle Goyo
nnoremap <leader>G :Goyo<CR>

" kien/ctrlp.vim ---------------------------------
" let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
" let g:ctrlp_use_caching = 0

" kshenoy/vim-signature --------------------------
" add a way to disable this for less wide margins
nnoremap <leader>m :SignatureToggleSigns<CR>

" lilydjwg/colorizer -----------------------------
" do not color more than 1000 lines at once
let g:colorizer_maxlines = 1000


" mbbill/undotree --------------------------------
nnoremap <leader>u :UndotreeShow<CR><C-w>h

" mhinz/vim-signify ------------------------------
" disable vim signify by default...
let g:signify_disable_by_default = 1
" but make a keyboard shortcut to show it when interested
nnoremap <leader>g :SignifyToggle<CR>

" neomake/neomake --------------------------------
" run python linter on write
" autocmd! BufWritePost *.py Neomake
" check code as python3 by default
" let g:neomake_python_python_maker = neomake#makers#ft#python#python()
" use flake8 to check python code
" let g:neomake_python_flake8_maker = neomake#makers#ft#python#flake8()

" neoclide/coc.nvim ------------------------------
source ~/.config/nvim/coc-settings.vim

" psf/black --------------------------------------

" Shougo/context_filetype.vim --------------------
" complete with words from any opened file
let g:context_filetype#same_filetypes = {}
" set underscore
let g:context_filetype#same_filetypes._ = '_'

" suan/vim-instant-markdown ----------------------
" always run on port 9876
let g:instant_markdown_port = 9876
" do not start when opening markdown file
let g:instant_markdown_autostart = 0
" obviously, enable markdown autoscroll
let g:instant_markdown_autoscroll = 1
" don't use the python server (requires npm package: `npm -g install instant-markdown-d`)
let g:instant_markdown_python = 0
" use custom webapp script to open browser:
let g:instant_markdown_browser = "webapp"

" tpope/vim-markdown -----------------------------
" inline code highlighting
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh']
" conceal markdown syntax
let g:markdown_syntax_conceal = 1
" highlight 100 lines
let g:markdown_minlines = 100

" valloric/MatchTagAlways ------------------------
" jump to other/closing tag
nnoremap <leader>. :MtaJumpToOtherTag<cr>

" vim airline ------------------------------------
" enable powerline fonts for vim airline
let g:airline_powerline_fonts = 1
" let g:airline_theme="base16_gruvbox_dark_hard"
let g:airline_theme="xresources_airline"

" wikitopian/hardmode ----------------------------
" enable hard mode (for practice purposes)
nnoremap <leader>h <Esc>:call ToggleHardMode()<CR>

" ycm-core/YouCompleteMe -------------------------
" nnoremap <leader>d :YcmCompleter GoTo<CR>
" nnoremap <leader>r :YcmCompleter RefactorRename<space>
" nnoremap <leader>r :YcmCompleter GoToReferences<CR>
" let g:ycm_min_num_of_chars_for_completion = 1
" let g:ycm_max_num_candidates = 6
" let g:ycm_auto_trigger = 1
" let g:ycm_confirm_extra_conf = 0
" let g:ycm_filetype_blacklist = ['python']
