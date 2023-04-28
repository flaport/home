-- Default Variable Settings
-- -------------------------------------------------------------------------------
-- these settings may change depending on the filetype or active extension

-- enable no wrapping (disable both hard wrapping and soft wrapping)
vim.opt.wrap = false
vim.opt.linebreak = false
vim.opt.formatoptions = "lqj"
vim.opt.textwidth = 0
vim.opt.colorcolumn = "0"

-- use unnamed register for clipboard
vim.opt.clipboard = 'unnamed'

-- disable automatic indent when moving to the next line while writing code
vim.opt.autoindent = false

-- show line numbers
vim.opt.number = true

-- relative line numbering
vim.opt.relativenumber = true

-- spell check, set default to en_us...
vim.opt.spell = false
vim.opt.spelllang = "en_us"

-- left margin width (max 12)
vim.opt.foldcolumn = "2"

-- show mode currently in (normal, insert, ...)
vim.opt.showmode = false

-- show where you are in the document in status bar (e.g. 143,61, 20%)
vim.opt.ruler = true

-- show status bar (0=disabled, 1=show half status bar, 2=show full status bar)
vim.opt.laststatus = 3

-- don't show last command executed
vim.opt.showcmd = true

-- set tabs to have a width of 2 spaces
vim.opt.tabstop = 2

-- set tabs to have a maximum width of 2 spaces
vim.opt.softtabstop = 2

-- set the shift operators (`<<` and `>>`) to insert 2 spaces
vim.opt.shiftwidth = 2
