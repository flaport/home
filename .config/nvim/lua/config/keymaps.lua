-- LOCALS
local opts = { noremap = true, silent = true }
local map = vim.keymap.set

-- open next buffer
map('n', '<leader>]', ':bnext<CR>', opts)

-- open previous buffer
map('n', '<leader>[', ':bprevious<CR>', opts)

-- jump to other/closing tag (requires valloric/MatchTagAlways)
map('n', '<leader>.', ':MtaJumpToOtherTag<cr>', opts)

-- cd into folder containing current file
map('n', '<leader>cd', ':lcd %:p:h<CR>', opts)

-- sort imports (python)
map('n', '<leader>fi', ':IsortSync<CR>', opts)

-- format code
-- [seems to be implemented elsewhere anyway and this one does not work] map('n', '<leader>F', ':lua vim.lsp.buf.format()', opts)

-- toggle git signify
map('n', '<leader>gt', ':SignifyToggle<CR>', opts)

-- shrink current horizontal split (decrease height)
map('n', '<leader>h', '3<C-w>-', opts)

-- make all splits horizontal
map('n', '<leader>H', '<C-w>t<C-w>K', opts)

-- toggle visible marks (requires vim-signature)
map('n', '<leader>m', ':SignatureToggleSigns<CR>', opts)

-- create tags
map('n', '<leader>T', ':silent !ctags -f .tags -R .<CR>', opts)

-- show undotree (requires mbbill/undotree)
map('n', '<leader>u', ':UndotreeShow<CR><C-w>h', opts)

-- shrink current vertical split (decrease width)
map('n', '<leader>v', '3<C-w><', opts)

-- make all splits vertical
map('n', '<leader>V', '<C-w>t<C-w>H', opts)

-- enable soft wrapping
map('n', '<leader>ws', ':SoftWrap<cr>', opts)
vim.api.nvim_create_user_command(
  'SoftWrap',
  'setlocal wrap linebreak formatoptions=lqj textwidth=0 colorcolumn=0',
  {}
)

-- enable no wrapping
map('n', '<leader>wn', ':NoWrap<cr>', opts)
vim.api.nvim_create_user_command(
  'NoWrap',
  'setlocal nowrap nolinebreak formatoptions=lqj textwidth=0 colorcolumn=0',
  {}
)

-- enable hard wrapping
map('n', '<leader>wh', ':HardWrap<cr>', opts)
vim.api.nvim_create_user_command(
  'HardWrap',
  'setlocal nowrap nolinebreak formatoptions=tqj textwidth=88 colorcolumn=88',
  {}
)

map('n', '<leader>s', ':call SyncTex()<CR>', { noremap = true, buffer = true, silent = true })

map('n', '<leader>xx', '<cmd>TroubleToggle<cr>', opts)
map('n', '<leader>xw', '<cmd>TroubleToggle workspace_diagnostics<cr>', opts)
map('n', '<leader>xd', '<cmd>TroubleToggle document_diagnostics<cr>', opts)
map('n', '<leader>xl', '<cmd>TroubleToggle loclist<cr>', opts)
map('n', '<leader>xq', '<cmd>TroubleToggle quickfix<cr>', opts)
map('n', 'gR', '<cmd>TroubleToggle lsp_references<cr>', opts)

-- null-ls formating
vim.keymap.set('n', '<leader>F', function()
  vim.lsp.buf.format {
    timeout_ms = 2000,
  }
end)

-- toggleterm
vim.api.nvim_set_keymap(
  'n',
  '<leader>lg',
  '<cmd>lua _LAZZYGIT()<CR>',
  { noremap = true, silent = false }
)

-- CONTROL BASED

-- show available leader shortcuts
map('n', '<C-Space>', ':WhichKey \\<space><cr>', opts)

-- increase number
-- <C-a> " standard vim keybinding

-- scroll page backward
-- <C-b> " standard vim keybinding

-- close current buffer
-- map("i", "<C-c>", "<Esc>:bd<CR>", opts)
-- map("n", "<C-c>", "<Esc>:bd<CR>", opts)

-- down half screen
map('n', '<C-d>', '<C-d>zz', opts)

-- exit terminal mode
map('t', '<C-e>', '<C-\\><C-N>', opts)

-- down full screen
map('n', '<C-f>', '<C-f>zz', opts)

-- up full screen
map('n', '<C-g>', '<C-g>zz', opts)

-- move to split left of current split
map('n', '<C-h>', '<C-w>h', opts)
map('t', '<C-h>', '<C-\\><C-N><C-w>h', opts)

-- jump forward in cursor position stack
-- <C-i> = TAB " standard vim keybinding

-- move to split below of current split (also when in terminal mode)
map('n', '<C-j>', '<C-w>j', opts)
map('t', '<C-j>', '<C-\\><C-N><C-w>j', opts)

-- move to split above of current split (also when in terminal mode)
map('n', '<C-k>', '<C-w>k', opts)
map('t', '<C-k>', '<C-\\><C-N><C-w>k', opts)

-- move to split right of current split (also when in terminal mode)
map('n', '<C-l>', '<C-w>l', opts)
map('t', '<C-l>', '<C-\\><C-N><C-w>l', opts)

-- move to first non-whitespace of next line
-- <C-m> " standard vim keybinding

-- jump backward in cursor position stack (opposite of <C-i> or TAB)
-- <C-o> " standard vim keybinding

-- save and exit
map('i', '<C-q>', '<Esc>:wqa<CR>', opts)
map('n', '<C-q>', '<Esc>:wqa<CR>', opts)

-- redo
-- <C-r> " standard vim keybinding

-- save buffer
map('i', '<C-s>', '<Esc>:w<CR>', opts)
map('n', '<C-s>', '<Esc>:w<CR>', opts)

-- go one step back in tag stack
-- <C-t> " standard vim keybinding

-- up half screen
map('n', '<C-u>', '<C-u>zz', opts)

function CloseBuffer()
  if vim.bo.filetype == 'netrw' then
    vim.cmd 'bd!'
  else
    local buf_list = vim.fn.getbufinfo { buflisted = 1 }
    local numbuffers = #buf_list
    if numbuffers > 1 then
      vim.cmd 'bd!'
    else
      vim.cmd 'q!'
    end
  end
end

map('i', '<C-c>', '<Esc>:lua CloseBuffer()<CR>', opts)
map('n', '<C-c>', '<Esc>:lua CloseBuffer()<CR>', opts)

-- visual block
-- <C-v> " standard vim keybinding

-- navigate between splits
-- <C-w> " standard vim keybinding

-- leader for autocomplete
-- <C-x> " standard vim keybinding

-- scroll text down with cursor staying where it is (opposite of <C-e>)
-- <C-y> " standard vim keybinding

-- suspend (like any other terminal process)
-- <C-z> " standard shell keybinding

-- cancel / go to normal mode
-- <C-[> " standard vim keybinding

-- use word under cursor to open next file with that tag
-- <C-]> " standard vim keybinding

-- go to last open buffer
-- <C-^> " standard vim keybinding

-- NORMAL MODE

-- toggle spell checker:
map('n', '<F3>', '<Esc>:setlocal spell!<CR>', opts)

-- choose spell checker language and enable
map('n', '<F3><F3>', '<Esc>:setlocal spell spelllang=', opts)

-- source init.vim again.
map('n', '<F4>', '<Esc>:source ~/.config/nvim/init.vim<CR>:edit<CR>', opts)

-- remap 'n' and 'N' to center screen after jumping to next match
map('n', 'n', 'nzz', opts)
map('n', 'N', 'Nzz', opts)

-- Remap for dealing with visual line wraps
map('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true }, opts)
map('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true }, opts)

-- Normal Mode (Leader-based)
map('n', '<leader><leader>', ':Telescope buffers<CR>', opts)

-- VISUAL MODE

-- paste over currently selected text without yanking it
map('v', 'p', '"_dp', opts)
map('v', 'P', '"_dP', opts)

-- move selected block up or down
map('v', '<C-j>', ":m '>+1<CR>gv=gv", opts)
map('v', '<C-k>', ":m '<-2<CR>gv=gv", opts)

-- TERMINAL MODE
-- go to edit mode in terminal emulator:
-- the backtick is there to not interfere with the <Esc> of the shell itself.
map('t', '<Esc>', '<C-\\><C-n>', opts)
-- keep original Escape available uner `<Esc>
map('t', '`<Esc>', '<Esc>', opts)

-- treesitter playground show highlight
map('n', 'T', ':TSHighlightCapturesUnderCursor<CR>', opts)

-- DEFAULTS

-- go to next misspelled word (enable spell checker with F3)
-- ]s " standard vim keybinding

-- go to previous misspelled word (enable spell checker with F3)
-- [s " standard vim keybinding

-- show suggestion for misspelled word (enable spell checker with F3)
-- z= " standard vim keybinding

-- add a word to the dictionary (enable spell checker with F3)
-- zg " standard vim keybinding

-- remove word from dictionary (enable spell checker with F3)
-- zuw " standard vim keybinding

-- fold all
-- zM " standard vim keybinding

-- unfold all
-- zR " standard vim keybinding

-- toggle fold
-- za " standard vim keybinding

-- unfold one
-- zv " standard vim keybinding

-- fold one
-- zc " standard vim keybinding

-- toggle comments
-- gc " from vim-commentary plugin

-- Set mark
-- m{letter}

-- jump to mark
-- `{letter}

-- jump to beginning of line at mark
-- '{letter}

-- search forward for {pattern}
-- /{pattern}

-- search forward for {pattern} and go {offset} lines up or down
-- /{pattern}/{offset} " Search forward for {pattern} and go {offset} lines up or down.

-- search forward for last used pattern
-- /<CR>

-- repeat the latest "/" or "?" [count] times.
-- n

-- repeat the latest "/" or "?" [count] times in opposite direction.
-- N

-- and many many more ;-)
