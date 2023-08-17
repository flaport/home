require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = "nord",
		-- component_separators = { left = "", right = "" },
		-- section_separators = { left = "", right = "" },
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = {},
		always_divide_middle = true,
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = {
			"branch",
			-- { "diff", colored = false },
			{
				"diagnostics",
				colored = false,
			},
		},
		lualine_c = {
			{
				"buffers",
				show_modified_status = false,
				max_length = vim.o.columns * 2 / 3,
				buffers_color = {
					-- Same values as the general color option can be used here.
					active = "lualine_a_normal", -- Color for active buffer.
					inactive = "lualine_c_normal", -- Color for inactive buffer.
				},
			},
		},
		lualine_x = { "encoding", "fileformat", "filetype" },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	extensions = { "nvim-tree", "neo-tree", "lazy", "toggleterm", "trouble", "fzf"},
})
-- custom theme
-- local custom_gruvbox = require("lualine.themes.gruvbox")

-- -- normal mode
-- custom_gruvbox.normal.a.fg = 0
-- custom_gruvbox.normal.a.bg = 10
-- custom_gruvbox.normal.b.fg = 15
-- custom_gruvbox.normal.b.bg = 8
-- custom_gruvbox.normal.c.fg = 15
-- custom_gruvbox.normal.c.bg = 0
-- -- insert mode
-- custom_gruvbox.insert.a.fg = 0
-- custom_gruvbox.insert.a.bg = 9
-- custom_gruvbox.insert.b.fg = 15
-- custom_gruvbox.insert.b.bg = 8
-- custom_gruvbox.insert.c.fg = 15
-- custom_gruvbox.insert.c.bg = 0
-- -- visual mode
-- custom_gruvbox.visual.a.fg = 0
-- custom_gruvbox.visual.a.bg = 11
-- custom_gruvbox.visual.b.fg = 15
-- custom_gruvbox.visual.b.bg = 8
-- custom_gruvbox.visual.c.fg = 15
-- custom_gruvbox.visual.c.bg = 0
-- -- replace mode
-- custom_gruvbox.replace.a.fg = 0
-- custom_gruvbox.replace.a.bg = 15
-- custom_gruvbox.replace.b.fg = 15
-- custom_gruvbox.replace.b.bg = 8
-- custom_gruvbox.replace.c.fg = 15
-- custom_gruvbox.replace.c.bg = 0
-- -- command mode
-- custom_gruvbox.command.a.fg = 0
-- custom_gruvbox.command.a.bg = 13
-- custom_gruvbox.command.b.fg = 15
-- custom_gruvbox.command.b.bg = 8
-- custom_gruvbox.command.c.fg = 15
-- custom_gruvbox.command.c.bg = 0
-- -- inactive mode
-- custom_gruvbox.inactive.a.fg = 0
-- custom_gruvbox.inactive.a.bg = 2
-- custom_gruvbox.inactive.b.fg = 0
-- custom_gruvbox.inactive.b.bg = 7
-- custom_gruvbox.inactive.c.fg = 15
-- custom_gruvbox.inactive.c.bg = 8
