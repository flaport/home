vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require("config.colors")
require("config.icons")
require("config.options")
require("config.variables")
require("config.autocmds")
require("plugins")
require("config.which_key_defaults")
require("config.keymaps")

vim.cmd([[source ~/.config/nvim/vim/commands.vim ]])
vim.cmd([[source ~/.config/nvim/vim/keymaps.vim ]])
vim.cmd([[source ~/.config/nvim/vim/neovim.vim ]])
vim.cmd([[source ~/.config/nvim/vim/python.vim ]])
vim.cmd([[source ~/.config/nvim/vim/rust.vim ]])
vim.cmd([[source ~/.config/nvim/vim/yaml.vim ]])
vim.cmd([[source ~/.config/nvim/vim/vimwiki.vim ]])
vim.cmd([[source ~/.config/nvim/vim/latex.vim ]])

vim.api.nvim_create_augroup("LspAttach_inlayhints", {})
vim.api.nvim_create_autocmd("LspAttach", {
	group = "LspAttach_inlayhints",
	callback = function(args)
		if not (args.data and args.data.client_id) then
			return
		end

		local bufnr = args.buf
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		require("lsp-inlayhints").on_attach(client, bufnr)
	end,
})
