vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function(use)
	use("wbthomason/packer.nvim")
	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.0",
		requires = { { "nvim-lua/plenary.nvim" } },
	})
	-- use({
	-- 	"rose-pine/neovim",
	-- 	as = "rose-pine",
	-- 	config = function()
	-- 		require("rose-pine").setup()
	-- 		vim.cmd("colorscheme rose-pine")
	-- 		SetColors()
	-- 	end,
	-- })
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	})
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

	-- cython syntax highlighting
	use({ "anntzer/vim-cython" })
	-- toml syntax highlighting
	use({ "cespare/vim-toml" })
	-- Python go-to-definition [autocompletion disabled]
	-- use({'davidhalter/jedi-vim'})
	-- add salt syntax highlighting for normal yaml files (custom fork of saltvim)
	use({ "vmware-archive/salt-vim" })
	-- jinja2 support in vim
	use({ "glench/vim-jinja2-syntax" })
	-- better integration between text and terminal buffers
	use({ "jpalardy/vim-slime" })
	-- fuzzy file finder (needs system wide fzf install)
	-- use({'junegunn/fzf.vim'})
	--, distraction free writing.
	-- use({'junegunn/goyo.vim'})
	-- show marks in margin
	use({ "kshenoy/vim-signature" })
	-- Icons in statusline
	use({ "kyazdani42/nvim-web-devicons" })
	-- jinja2 support
	use({ "lepture/vim-jinja" })
	-- paint css colors with the real color
	use({ "lilydjwg/colorizer" })
	-- emmet for vim
	-- use({'mattn/emmet-vim'})
	-- undo tree for vim
	use({ "mbbill/undotree" })
	-- git/mercurial/others diff icons on the side of the file lines
	use({ "mhinz/vim-signify" })
	-- blazing fast status line
	use({ "nvim-lualine/lualine.nvim" })
	-- better folding for yaml files
	use({ "pedrohdz/vim-yaml-folds" })
	-- vuejs syntax highlighting
	-- use({'posva/vim-vue'})
	-- completion from other opened files
	use({ "shougo/context_filetype.vim" })
	-- markdown viewer
	use({ "suan/vim-instant-markdown" })
	-- easy comment
	use({ "tpope/vim-commentary" })
	-- better git integration
	use({ "tpope/vim-fugitive" })
	-- easily repeat plugin commands with .
	use({ "tpope/vim-repeat" })
	-- increase date with <C-A>
	use({ "tpope/vim-speeddating" })
	-- easily surround word with quotes or tags
	use({ "tpope/vim-surround" })
	-- highlight matching html tags
	use({ "valloric/MatchTagAlways" })
	-- man pages in vim
	-- use({'vim-utils/vim-man'})
	-- note taking in vim
	use({ "vimwiki/vimwiki" })
	-- vim hard mode (useful for training)
	-- use({'wikitopian/hardmode'})
end)
