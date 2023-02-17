vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function(use)
	use("wbthomason/packer.nvim")
	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.0",
		requires = { { "nvim-lua/plenary.nvim" } },
	})
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	})
	-- Configurations for Nvim LSP
	use({ "neovim/nvim-lspconfig" })
	-- better integration between text and terminal buffers
	use({ "jpalardy/vim-slime" })
	-- note taking in vim
	use({ "vimwiki/vimwiki" })
	-- highlight matching html tags
	use({ "valloric/MatchTagAlways" })
	-- toml syntax highlighting
	use({ "cespare/vim-toml" })
	-- better folding for yaml files
	use({ "pedrohdz/vim-yaml-folds" })
	-- add salt syntax highlighting for normal yaml files (custom fork of saltvim)
	use({ "vmware-archive/salt-vim" })
	-- blazing fast status line
	use({ "nvim-lualine/lualine.nvim" })
	-- git/mercurial/others diff icons on the side of the file lines
	use({ "mhinz/vim-signify" })
	-- emmet for vim
	use({ "mattn/emmet-vim" })
	-- paint css colors with the real color
	use({ "lilydjwg/colorizer" })
	-- jinja2 support
	use({ "lepture/vim-jinja" })
	-- jinja2 support in vim
	use({ "glench/vim-jinja2-syntax" })
  -- inlayhints (very useful for Rust)
	use({ "lvimuser/lsp-inlayhints.nvim" })
  -- git support
	use({ "tpope/vim-fugitive" })
	use({
		"VonHeikemen/lsp-zero.nvim",
		branch = "v1.x",
		requires = {
			-- LSP Support
			{ "neovim/nvim-lspconfig" }, -- Required
			{ "williamboman/mason.nvim" }, -- Optional
			{ "williamboman/mason-lspconfig.nvim" }, -- Optional

			-- Autocompletion
			{ "hrsh7th/nvim-cmp" }, -- Required
			{ "hrsh7th/cmp-nvim-lsp" }, -- Required
			{ "hrsh7th/cmp-buffer" }, -- Optional
			{ "hrsh7th/cmp-path" }, -- Optional
			{ "saadparwaiz1/cmp_luasnip" }, -- Optional
			{ "hrsh7th/cmp-nvim-lua" }, -- Optional

			-- Snippets
			{ "L3MON4D3/LuaSnip" }, -- Required
			{ "rafamadriz/friendly-snippets" }, -- Optional
		},
	})
	use({
		"folke/trouble.nvim",
		requires = "nvim-tree/nvim-web-devicons",
		config = function()
			require("trouble").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			})
		end,
	})
	-- use({
	-- 	"rose-pine/neovim",
	-- 	as = "rose-pine",
	-- 	config = function()
	-- 		require("rose-pine").setup()
	-- 		vim.cmd("colorscheme rose-pine")
	-- 	end,
	-- })
	-- Visualize lsp progress
	use({
		"j-hui/fidget.nvim",
		config = function()
			require("fidget").setup()
		end,
	})

	-- Autocompletion framework
	use("hrsh7th/nvim-cmp")
	use({
		-- cmp LSP completion
		"hrsh7th/cmp-nvim-lsp",
		-- cmp Snippet completion
		"hrsh7th/cmp-vsnip",
		-- cmp Path completion
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-buffer",
		after = { "hrsh7th/nvim-cmp" },
		requires = { "hrsh7th/nvim-cmp" },
	})
	-- See hrsh7th other plugins for more great completion sources!
	-- Snippet engine
	use("hrsh7th/vim-vsnip")
	-- Adds extra functionality over rust analyzer
	use("simrat39/rust-tools.nvim")

	-- Optional
	use("nvim-lua/popup.nvim")
	use("nvim-lua/plenary.nvim")
end)
