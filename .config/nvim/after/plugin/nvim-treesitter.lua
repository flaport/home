require("nvim-treesitter.configs").setup({
	-- A list of parser names, or "all" (the four listed parsers should always be installed)
	ensure_installed = {
		"bash",
		"c",
		"html",
		"javascript",
		"json",
		"lua",
		"luadoc",
		"luap",
		"markdown",
		"markdown_inline",
		"python",
		"query",
		"regex",
		"tsx",
		"typescript",
		"vim",
		"vimdoc",
		"yaml",
		"rust",
		"go"
	},

	-- Install parsers synchronously (only applied to `ensure_installed`)
	sync_install = false,

	-- Automatically install missing parsers when entering buffer
	-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
	auto_install = true,

	-- List of parsers to ignore installing (for "all")
	ignore_install = { "help" },

	---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
	-- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!
	indent = { enable = true },

	context_commentstring = { enable = true, enable_autocmd = false },

	incremental_selection = {
		enable = true,
		keymaps = {
		init_selection = "<leader>v",
		node_incremental = "+",
		scope_incremental = false,
		node_decremental = "_",
		},
	},
	highlight = {
		-- `false` will disable the whole extension
		enable = true,

		-- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
		-- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
		-- the name of the parser)
		-- list of language that will be disabled
		-- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
		disable = function(lang, buf)
			local max_filesize = 100 * 1024 -- 100 KB
			local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
			if ok and stats and stats.size > max_filesize then
				return true
			end
		end,

		-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
		-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
		-- Using this option may slow down your editor, and you may see some duplicate highlights.
		-- Instead of true it can also be a list of languages
		additional_vim_regex_highlighting = false,
	},
	textobjects = {
		select = {
		enable = true,
		lookahead = true,

		keymaps = {
			-- You can use the capture groups defined in textobjects.scm
			["af"] = { query = "@function.outer", desc = "around a function" },
			["if"] = { query = "@function.inner", desc = "inner part of a function" },
			["ac"] = { query = "@class.outer", desc = "around a class" },
			["ic"] = { query = "@class.inner", desc = "inner part of a class" },
			["ai"] = { query = "@conditional.outer", desc = "around an if statement" },
			["ii"] = { query = "@conditional.inner", desc = "inner part of an if statement" },
			["al"] = { query = "@loop.outer", desc = "around a loop" },
			["il"] = { query = "@loop.inner", desc = "inner part of a loop" },
			["ap"] = { query = "@parameter.outer", desc = "around parameter" },
			["ip"] = { query = "@parameter.inner", desc = "inside a parameter" },
		},
		selection_modes = {
			["@parameter.outer"] = "v", -- charwise
			["@parameter.inner"] = "v", -- charwise
			["@function.outer"] = "v", -- charwise
			["@conditional.outer"] = "V", -- linewise
			["@loop.outer"] = "V", -- linewise
			["@class.outer"] = "<c-v>", -- blockwise
		},
		include_surrounding_whitespace = false,
		},
		move = {
		enable = true,
		set_jumps = true, -- whether to set jumps in the jumplist
		goto_previous_start = {
			["[f"] = { query = "@function.outer", desc = "Previous function" },
			["[c"] = { query = "@class.outer", desc = "Previous class" },
			["[p"] = { query = "@parameter.inner", desc = "Previous parameter" },
		},
		goto_next_start = {
			["]f"] = { query = "@function.outer", desc = "Next function" },
			["]c"] = { query = "@class.outer", desc = "Next class" },
			["]p"] = { query = "@parameter.inner", desc = "Next parameter" },
		},
		},
	},
})

-- set treesitter folding
vim.opt.foldmethod="expr"
vim.opt.foldexpr="nvim_treesitter#foldexpr()"
-- vim.opt.foldmethod="indent"
-- vim.opt.foldlevel=99
vim.opt.foldnestmax=2
vim.opt.foldlevelstart=1
vim.opt.foldenable = true

-- fix the problem of telescope messing up with code folding
vim.api.nvim_create_autocmd({ "BufRead" }, { pattern = { "*" }, command = "normal zx", })
