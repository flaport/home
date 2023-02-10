-- Options
-- Leader Key
vim.g.mapleader = " "

-- Filetypes
-- neovim 0.7: only use filetype.lua not fallback to filtype.vim
-- vim.g.do_filetype_lua = 1
-- vim.g.did_load_filetypes = 0
-- vim.opt.filetype = true
-- vim.opt.plugin = true
-- vim.opt.indent = "on"

-- vim.cmd 'syntax on' -- disabled for treesitter syntax

-- Fixed settings
-------------------------------------------------------------------------------------------
-- These settings won't change, no matter the filetype or active extension

--when scrolling, keep cursor in the middle of the page (disabled, use zz to center)
vim.opt.scrolloff = 0

-- allow pattern matching with special characters during search
vim.opt.magic = true

-- case insensitive search when searching with lower case characters
vim.opt.ignorecase = true

-- case sensitive search when searching with upper case characters
vim.opt.smartcase = true

-- enable unicode
vim.opt.encoding = "utf-8"

-- Give more space for displaying messages(2), but now I set it to 1.
vim.opt.cmdheight = 1

-- allow opening a new buffer without saving the current one
vim.opt.hidden = true

-- Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
-- delays and poor user experience.
vim.opt.updatetime = 300

-- Some lsp servers have issues with backup files, see #649.
vim.opt.backup = false
vim.opt.writebackup = false

-- Always show the signcolumn, otherwise it would shift the text each time
-- diagnostics appear/become resolved.
vim.opt.signcolumn = "yes"

-- when searching, search down into all subfolders
vim.opt.path = vim.opt.path:append("**")

-- new vertical splits appear on the right
vim.opt.splitright = true

-- new horizontal splits appear below
vim.opt.splitbelow = true

-- tell vim where to find the ctags
vim.opt.tags = "./.tags;,.tags;"

-- enable mouse clicks
vim.opt.mouse = "a"

-- copy to star register by default (selection copy)
vim.opt.clipboard = vim.opt.clipboard:prepend("unnamed")

-- code folding
-- zM: fold all; zR: unfold all; za: toggle fold, zv: unfold one; zc: fold one
vim.opt.foldmethod = "manual"

-- show the matching part of the pair for [] {} and ()
vim.opt.showmatch = true

-- fix problems with uncommon shells (fish, zsh, xonsh, ...) and plugins
-- running shell commands (neomake, ...)
vim.opt.shell = "/usr/bin/zsh"

-- better autocomplete:
vim.opt.wildmenu = true

-- enable unlimited undo
vim.opt.undofile = true

-- set undi directory where unlimited history can be saved it is not working! TODO
vim.opt.undodir = vim.fn.expand("~/.local/share/nvim/undo")

-- disable netrw banner
vim.g.netrw_banner = false

-- Default Variable Settings
-------------------------------------------------------------------------------
-- these settings may change depending on the filetype or active extension
vim.opt.wrap = false
vim.opt.linebreak = false
vim.opt.formatoptions = "lqj"
vim.opt.textwidth = 0
-- vim.opt.colorcolumn = 0

-- disable automatic indent when moving to the next line while writing code
vim.opt.autoindent = false

-- show line numbers
-- vim.opt.number = "0"

-- relative line numbering (disabled)
vim.opt.relativenumber = false

-- spell check default to en_us
vim.opt.spell = false
vim.opt.spelllang = "en_us"

-- left margin width (max 12)
vim.opt.foldcolumn = "1"

-- show mode currently in (normal, insert, ...)
vim.opt.showmode = false

-- show where you are in the document in status bar (e.g. 143,61, 20%)
-- vim.opt.ruler =true

-- show status bar (0=disabled, 1=show half status bar, 2=show full status bar, 3=global statusbar)
vim.opt.laststatus = 3

-- don't show last command executed
vim.opt.showcmd = false

-- TODO: what is the best?
-- replace tabs by spaces
vim.opt.expandtab = true

-- set tabs to have a width of 2 spaces
-- vim.opt.tabstop = 2
vim.opt.tabstop = 4

-- set tabs to have a maximum width of 2 spaces
-- vim.opt.softtabstop = 2
vim.opt.softtabstop = 4

-- set the shift operators (`<<` and `>>`) to insert 2 spaces
vim.opt.shiftwidth = 4

-- vim.api.nvim_create_user_command('Upper', 'echo toupper(<q-args>)', { nargs = 1 })
-- -- :command! -nargs=1 Upper echo toupper(<q-args>)

-------------------------------------------------------------------------------

local fixedgroup = vim.api.nvim_create_augroup("FixedGroup", { clear = true })
vim.api.nvim_create_autocmd("InsertEnter", { pattern = "*", command = "set cul", group = fixedgroup })
vim.api.nvim_create_autocmd("InsertLeave", { pattern = "*", command = "set nocul", group = fixedgroup })
vim.api.nvim_create_autocmd(
	"FileType",
	{ pattern = "*", command = "setlocal formatoptions-=c formatoptions-=r formatoptions-=o", group = fixedgroup }
)
-- vim.api.nvim_create_autocmd("SyntaxSync", {command="autocmd BufEnter * syntax sync fromstart", group = fixedgroup}
