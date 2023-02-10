-- Custom Commands
-- ------------------------------------------------------------------------------
-- these commands may change depending on the filetype or active extension

-- open a new fullscreen terminal
vim.api.nvim_create_user_command("T", 'call NewTerminal("")', {})

-- open a new horiontal terminal
vim.api.nvim_create_user_command("HT", 'call NewHorizontalTerminal("")', {})

-- open a new vertical terminal
vim.api.nvim_create_user_command("VT", 'call NewVerticalTerminal("")', {})

-- enable soft wrapping (no enter inserted) at end of window
vim.api.nvim_create_user_command("SoftWrap", "setlocal wrap linebreak formatoptions=lqj textwidth=0 colorcolumn=0", {})

-- enable hard wrapping (insert enter) at 88 characters
vim.api.nvim_create_user_command(
	"HardWrap",
	"setlocal nowrap nolinebreak formatoptions=tqj textwidth=88 colorcolumn=88",
	{}
)

-- enable no wrapping (disable both hard wrapping and soft wrapping)
vim.api.nvim_create_user_command(
	"NoWrap",
	"setlocal nowrap nolinebreak formatoptions=lqj textwidth=0 colorcolumn=0",
	{}
)
