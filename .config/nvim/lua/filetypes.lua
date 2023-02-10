require("variables")

local ftgroup = vim.api.nvim_create_augroup("filetypes", { clear = true })
vim.api.nvim_create_autocmd(
	{ "BufNewFile", "BufEnter", "BufRead" },
	{ pattern = "*", command = "filetype on", group = ftgroup }
)
vim.api.nvim_create_autocmd(
	{ "BufNewFile", "BufEnter", "BufRead" },
	{ pattern = "*", command = "filetype plugin on", group = ftgroup }
)
vim.api.nvim_create_autocmd(
	{ "BufNewFile", "BufEnter", "BufRead" },
	{ pattern = "*", command = "filetype indent on", group = ftgroup }
)
vim.api.nvim_create_autocmd(
	{ "BufNewFile", "BufEnter", "BufRead" },
	{ pattern = { "*.vim", "*.vimrc", "*vifmrc", "init.vim" }, command = "setlocal filetype=vim", group = ftgroup }
)
vim.api.nvim_create_autocmd(
	{ "BufNewFile", "BufEnter", "BufRead" },
	{ pattern = "*.ipynb", command = "setlocal filetype=ipynb", group = ftgroup }
)
vim.api.nvim_create_autocmd(
	{ "BufNewFile", "BufEnter", "BufRead" },
	{ pattern = { "*.tex", "*.sty" }, command = "setlocal filetype=tex", group = ftgroup }
)
vim.api.nvim_create_autocmd(
	{ "BufNewFile", "BufEnter", "BufRead" },
	{ pattern = { "*.txt", "/tmp/neomutt*" }, command = "setlocal filetype=text", group = ftgroup }
)
vim.api.nvim_create_autocmd(
	{ "BufNewFile", "BufEnter", "BufRead" },
	{
		pattern = { "*.md", "/tmp/calcurse*", vim.fn.expand("~/.calcurse/notes/*") },
		command = "setlocal filetype=vimwiki",
		group = ftgroup,
	}
)
vim.api.nvim_create_autocmd(
	{ "BufNewFile", "BufEnter", "BufRead" },
	{ pattern = { "*.py" }, command = "setlocal filetype=python", group = ftgroup }
)
