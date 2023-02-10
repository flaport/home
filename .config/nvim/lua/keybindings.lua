require("commands")

local telescope = require("telescope.builtin")

--  Variable Leader-based Keyboard Shortcuts
-- -------------------------------------------------------------------------------
--  these settings may change depending on the filetype or active extension

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex) -- ***
vim.keymap.set("n", "<leader>ff", telescope.find_files, {})
vim.keymap.set("n", "<leader>fg", telescope.live_grep, {})
vim.keymap.set("n", "<leader>fb", telescope.buffers, {})
vim.keymap.set("n", "<leader>fh", telescope.help_tags, {})
vim.keymap.set("n", "<leader>ps", function()
	telescope.grep_string({ search = vim.fn.input("Grep > ") })
end)

--  turn of highlighting
-- nnoremap <leader><leader> :noh<cr>

--  open next buffer
-- nnoremap <leader>] :bnext<CR>

--  open previous buffer
-- nnoremap <leader>[ :bprevious<CR>

--  fuzzy find content in current buffer (requires junegunn/fzf)
-- nnoremap <leader>/ :BLines<CR>

--  jump to other/closing tag (requires valloric/MatchTagAlways)
-- nnoremap <leader>. :MtaJumpToOtherTag<cr>

--  noop
--  nnoremap <leader>a :echo \<leader\>a<cr>
-- nnoremap <leader>A :echo \<leader\>A<cr>

--  noop
-- nnoremap <leader>b :echo \<leader\>b<cr>
-- nnoremap <leader>B :echo \<leader\>B<cr>

--  Treesitter show highlight group
-- nnoremap <silent> T :TSHighlightCapturesUnderCursor<CR>

-- Fixed CTRL-based Keyboard Shortcuts
-- -------------------------------------------------------------------------------
-- these keyboard shortcuts won't change, no matter the filetype or active extension

--  increase number
--  <C-a>  standard vim keybinding

--  scroll page backward
--  <C-b>  standard vim keybinding
--  inoremap <silent> <C-b> <C-r>=CocActionAsync('showSignatureHelp')<CR>

--  exit current buffer without saving
-- function! CloseBuffer()
--     if &filetype == netrw
--         exec bd!
--     else
--         let numbuffers = len(getbufinfo({'buflisted':1}))
--         if numbuffers > 1
--             exec bd!
--         else
--             exec q!
--         endif
--     endif
-- endfunction

--  close current buffer
-- inoremap <C-c> <Esc>:call CloseBuffer()<CR>
-- nnoremap <C-c> <Esc>:call CloseBuffer()<CR>

--  down half screen
--  <C-d>  standard vim keybinding

--  scroll text up with cursor staying where it is (opposite of <C-y>)
--  <C-e>  standard vim keybinding

--  exit terminal mode
-- tnoremap <C-e> <C-\><C-N>

--  down full screen
--  <C-f>  standard vim keybinding

--  show status
--  <C-g>  standard vim keybinding

--  increase master area (requires dwm.vim)
--  nmap <C-h> <Plug>DWMShrinkMaster
--  nmap <C-h> :vertical resize +5<CR>
--  DISABLED: move to split left of current split (also when in terminal mode)
--  nnoremap <C-h> <C-w>h
--  tnoremap <C-h> <C-\><C-N><C-w>h
--  nmap <C-h> <Plug>DWMShrinkMaster
--  move to split left of current split (also when in terminal mode)
-- nnoremap <C-h> <C-w>h
-- tnoremap <C-h> <C-\><C-N><C-w>h

--  DISABLED: jump forward in cursor position stack (same as TAB; opposite of <C-o>)
--  <C-i> = TAB  standard vim keybinding

--  move to next split in clockwise direction (requires dwm.vim)
--  nmap <C-j> <C-w>w
--  move to split below of current split (also when in terminal mode)
-- nnoremap <C-j> <C-w>j
-- tnoremap <C-j> <C-\><C-N><C-w>j

--  move to previous split in anticlockwise direction (requires dwm.vim)
--  nmap <C-k> <C-w>W
--  move to split above of current split (also when in terminal mode)
-- nnoremap <C-k> <C-w>k
-- tnoremap <C-k> <C-\><C-N><C-w>k

--  decrease master area (requires dwm.vim)
--  nmap <C-l> <Plug>DWMGrowMaster
--  nmap <C-l> :vertical resize -5<CR>
--  DISABLED: move to split right of current split (also when in terminal mode)
--  nnoremap <C-l> <C-w>l
--  tnoremap <C-l> <C-\><C-N><C-w>l
--  nmap <C-l> <Plug>DWMGrowMaster
--  move to split right of current split (also when in terminal mode)
-- nnoremap <C-l> <C-w>l
-- tnoremap <C-l> <C-\><C-N><C-w>l

--  move to first non-whitespace of next line
--  <C-m>  standard vim keybinding

--  create new split in master area (requires dwm.vim)
--  nmap <C-n> <Plug>DWMNew

--  jump backward in cursor position stack (opposite of <C-i> or TAB)
--  <C-o>  standard vim keybinding

--  fuzzy open file with fzf (requires fzf plugin)
vim.keymap.set("n", "<C-p>", telescope.git_files, {})

--  save and exit
-- inoremap <C-q> <Esc>:wqa<CR>
-- nnoremap <C-q> <Esc>:wqa<CR>

--  redo
--  <C-r>  standard vim keybinding

--  save buffer
-- inoremap <C-s> <Esc>:w<CR>
-- nnoremap <C-s> <Esc>:w<CR>

--  go one step back in tag stack
--  <C-t>  standard vim keybinding

--  up half screen
--  <C-u>  standard vim keybinding

--  visual block
--  <C-v>  standard vim keybinding

--  navigate between splits
--  <C-w>  standard vim keybinding

--  leader for autocomplete
--  <C-x>  standard vim keybinding

--  scroll text down with cursor staying where it is (opposite of <C-e>)
--  <C-y>  standard vim keybinding

--  suspend (like any other terminal process)
--  <C-z>  standard shell keybinding

--  cancel / go to normal mode
--  <C-[>  standard vim keybinding

--  use word under cursor to open next file with that tag
--  <C-]>  standard vim keybinding

--  go to last open buffer
--  <C-^>  standard vim keybinding
