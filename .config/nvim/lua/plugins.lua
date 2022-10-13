local fn = vim.fn
local map = vim.api.nvim_set_keymap
local keymap_opt = { noremap = true, silent = true }

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	packer_bootstrap = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
end

-- Autocommand that compile packer whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

return packer.startup({
	function(use)
		-- My plugins here
		-- Infrastructure
		use({ "wbthomason/packer.nvim", opt = false })
		use({ "nvim-lua/plenary.nvim" })
		use({ "nvim-lualine/lualine.nvim", requires = { "kyazdani42/nvim-web-devicons", opt = true } })
		use({ "kyazdani42/nvim-tree.lua", requires = { "kyazdani42/nvim-web-devicons" } })
		use({
			"nvim-treesitter/nvim-treesitter",
			run = ":TSUpdate",
		})
		use({ "nvim-treesitter/playground" })
		use({ "akinsho/toggleterm.nvim" })

		-- coc
		-- use({ "neoclide/coc.nvim", branch = "release" })

		-- cmp related: auto complete and so on...
		use({ "hrsh7th/nvim-cmp" })
		use({ "hrsh7th/cmp-nvim-lsp" })
		use({ "hrsh7th/cmp-buffer" })
		use({ "hrsh7th/cmp-path" })
		use({ "hrsh7th/cmp-nvim-lua" })
		use({ "hrsh7th/cmp-nvim-lsp-signature-help" }) -- expand function keywords expaination
		-- use({ "hrsh7th/cmp-cmdline" })
		-- -- use({ "lukas-reineke/cmp-rg" }) -- regrip
		-- use({ "Saecki/crates.nvim" }) -- rust crates

		use({ "L3MON4D3/LuaSnip" }) -- snippet engine
		use({ "saadparwaiz1/cmp_luasnip" }) -- luasnip hook for cmp
		use({ "onsails/lspkind-nvim" }) -- icons

		-- -- lsp related
		use({ "neovim/nvim-lspconfig" }) -- enable LSP
		use({ "williamboman/nvim-lsp-installer" }) -- simple to use language server installer
		use({ "jose-elias-alvarez/null-ls.nvim", disable = false }) -- unversal formatter

		-- Utility
		-- Easy motion in vim
		use({
			"phaazon/hop.nvim",
			branch = "v1",
			config = function()
				require("hop").setup({})
				vim.cmd([[nnoremap s <cmd>HopChar2<CR>]])
			end,
		})
		-- easy comment
		use({
			'numToStr/Comment.nvim',
			config = function()
				require('Comment').setup()
			end
		})
		-- fzf
		use({ 'junegunn/fzf' })
		use({ 'junegunn/fzf.vim' })
		-- vim hard mode (useful for training)
		use({
			"takac/vim-hardtime",
			disable = true,
			config = function()
				vim.g.hardtime_default_on = 0
				vim.g.hardtime_maxcount = 3
				vim.g.hardtime_allow_different_key = 1
				vim.g.list_of_normal_keys = { "j", "k", "h", "l" }
				vim.g.list_of_visual_keys = { "h", "l" }
			end
		})

		-- quick movement within line
		use({ "unblevable/quick-scope" })

		-- autopair
		use({ "windwp/nvim-autopairs", })

		-- python
		use({ "jpalardy/vim-slime", ft = { "python" } })
		use({ "hanschen/vim-ipython-cell", ft = { "python" } })

		-- check startuptime with :StartUpTime
		use({ "dstein64/vim-startuptime" })
		-- use({ "justinmk/vim-sneak", disable = true })

		-- colorschemes for neovide
		use "EdenEast/nightfox.nvim"
		use "savq/melange" -- warm colorschem

		-- Automatically set up your configuration after cloning packer.nvim
		-- Put this at the end after all plugins
		if packer_bootstrap then
			require("packer").sync()
		end
	end,
	-- floatwindow prompt for packer commands
	-- config = {
	-- 	display = {
	-- 		open_fn = function()
	-- 			return require("packer.util").float({ border = "rounded" })
	-- 		end,
	-- 	},
	-- },
})
