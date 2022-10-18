local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
	return
end

local lspkind_status_ok, lspkind = pcall(require, "lspkind")
if not lspkind_status_ok then
	return
end

vim.opt.completeopt = { "menu", "menuone", "noselect" }

cmp.setup({
	snippet = {
		expand = function(args)
			require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
		end,
	},
	window = {
		-- completion = cmp.config.window.bordered(),
		-- documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		['<C-b>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.abort(),
		['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	}),
	-- source module to be used (order matters)
	sources = cmp.config.sources({
		{ name = 'nvim_lsp', max_item_count = 10 },
		{ name = 'luasnip' }, -- For luasnip users.
		{ name = 'nvim_lsp_signature_help' },
		{ name = 'buffer', keyword_length = 3 },
		{ name = 'path' },
	}),
	formatting = {
		format = lspkind.cmp_format({
			mode = "symbol_text",
			menu = ({
				buffer = "[Buf]",
				nvim_lsp = "[LSP]",
				luasnip = "[Snip]",
				path = "[Path]",
				-- latex_symbols = "[Latex]",
			})
		}),
	},
})




-- local snip_status_ok, luasnip = pcall(require, "luasnip")
-- if not snip_status_ok then
-- 	return
-- end

-- local lspkind_status_ok, lspkind = pcall(require, "lspkind")
-- if not lspkind_status_ok then
-- 	return
-- end

-- lspkind.init()


-- --   פּ ﯟ   some other good icons
-- local kind_icons = {
-- 	Text = "",
-- 	Method = "m",
-- 	Function = "",
-- 	Constructor = "",
-- 	Field = "",
-- 	Variable = "",
-- 	Class = "",
-- 	Interface = "",
-- 	Module = "",
-- 	Property = "",
-- 	Unit = "",
-- 	Value = "",
-- 	Enum = "",
-- 	Keyword = "",
-- 	Snippet = "",
-- 	Color = "",
-- 	File = "",
-- 	Reference = "",
-- 	Folder = "",
-- 	EnumMember = "",
-- 	Constant = "",
-- 	Struct = "",
-- 	Event = "",
-- 	Operator = "",
-- 	TypeParameter = "",
-- }
-- -- find more here: https://www.nerdfonts.com/cheat-sheet

-- cmp.setup({
-- 	snippet = {
-- 		expand = function(args)
-- 			require("luasnip").lsp_expand(args.body)
-- 		end,
-- 	},
-- 	mapping = {
-- 		["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
-- 		["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
-- 		["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
-- 		["<C-y>"] = cmp.config.disable,
-- 		["<C-e>"] = cmp.mapping({
-- 			i = cmp.mapping.abort(),
-- 			c = cmp.mapping.close(),
-- 		}),
-- 		["<CR>"] = cmp.mapping.confirm({ select = false }),
-- 	},
-- 	sources = {
-- 		{ name = "nvim_lua" },
-- 		{ name = "nvim_lsp" },
-- 		{ name = "luasnip" },
-- 		{ name = "crates" },
-- 		{ name = "rg" },
-- 		{ name = "cmdline" },
-- 		{ name = "path" },
-- 		{ name = "buffer", keyword_length = 3 },
-- 	},
-- 	formatting = {
-- 		-- Youtube: How to set up nice formatting for your sources.
-- 		format = lspkind.cmp_format({
-- 			with_text = true,
-- 			menu = {
-- 				buffer = "[buf]",
-- 				nvim_lsp = "[LSP]",
-- 				nvim_lua = "[api]",
-- 				path = "[path]",
-- 				luasnip = "[snip]",
-- 				tn = "[TabNine]",
-- 			},
-- 		}),
-- 	},
-- 	experimental = {
-- 		-- I like the new menu better! Nice work hrsh7th
-- 		native_menu = false,
-- 		-- Let's play with this for a day or two
-- 		ghost_text = false,
-- 	},
-- })
