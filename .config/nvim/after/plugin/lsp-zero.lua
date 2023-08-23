-- setup lsp-zero
local lsp = require('lsp-zero').preset({
	manage_nvim_cmp = {
	set_sources = 'lsp',
	set_basic_mappings = false,
	set_extra_mappings = false,
	use_luasnip = true,
	set_format = true,
	documentation_window = true,
	}
})

lsp.ensure_installed({
	"tsserver",
	"eslint",
	"rust_analyzer",
	"pyright",
	"lua_ls",
})

lsp.set_preferences({
	sign_icons = {},
})

lsp.omnifunc.setup({select_behavior="insert"})
lsp.setup_nvim_cmp({select_behavior="insert"})

-- LSP related setup
lsp.on_attach(function(client, bufnr)
	-- see :help lsp-zero-keybindings
	-- to learn the available actions
	lsp.default_keymaps({buffer = bufnr})
end)

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
-- vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local custom_attach = function(client, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
	vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
	vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, bufopts)
	vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
	vim.keymap.set("n", "<leader>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, bufopts)
	vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, bufopts)
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
	vim.keymap.set("n", "<leader>f", function()
		vim.lsp.buf.format({ async = true })
	end, bufopts)
end

-- lsp zero defaults
    -- vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
    -- vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
    -- vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
    -- vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
    -- vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
    -- vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
    -- vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
    -- vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
    -- vim.keymap.set({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
    -- vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)

    -- vim.keymap.set('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>', opts)
    -- vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>', opts)
    -- vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>', opts)

local lsp_flags = {
	-- This is the default in Nvim 0.7+
	debounce_text_changes = 150,
}

local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
	return
end

--  a language server for Lua.
lspconfig.lua_ls.setup({
	-- cmd = { sumneko_binary, "-E", sumneko_root_path .. "/main.lua" };
	-- An example of settings for an LSP server.
	--    For more options, see nvim-lspconfig
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = 'LuaJIT',
				-- Setup your lua path
				path = vim.split(package.path, ';'),
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { 'vim' },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = {
					[vim.fn.expand('$VIMRUNTIME/lua')] = true,
					[vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
				},
			},
		}
	},
	on_attach = custom_attach,
})

-- -- read .vscode/settings if there is one. Mainly for ipkiss environment
-- local get_vscode_python_path = function()
-- 	if vim.fn.filereadable(".vscode/settings.json") ~= 1 then
-- 		-- vim.schedule(function() print("there is no settings.json file") end)
-- 		return
-- 	end
--
-- 	local io = require("io")
-- 	local file = io.open(".vscode/settings.json")
-- 	if file == nil then
-- 		vim.schedule(function() print("settings.json file not readable") end)
-- 		return
-- 	end
-- 	if file ~= nil then
-- 		local content = file:read "*a"
-- 		file:close()
-- 		local content = content:gsub("%s*//.-\n", "\n") -- https://www.lua.org/pil/20.2.html for lua patterns
-- 		-- print(content)
-- 		local status_ok, table1 = pcall(vim.json.decode, content)
-- 		if not status_ok then
-- 			vim.schedule(function() print(".vscode/settings.json parse failed, check it.") end)
-- 			return
-- 		end
-- 		-- local table1 = vim.fn.json_decode(content)
-- 		local status_ok, vscode_pythonpath = pcall(function() return table1["terminal.integrated.env.linux"].PYTHONPATH end)
-- 		if status_ok then
-- 			vim.g.vscode_pythonpath = vscode_pythonpath
-- 		end
-- 		local status_ok, extraPath = pcall(function() return table1["python.analysis.extraPaths"].PYTHONPATH end)
-- 		if status_ok then
-- 			vim.g.Pyright_analysis_pathv = extraPath
-- 			vim.schedule(function() print("vscode settings for pyright loaded successfuly") end)
-- 			return vim.g.Pyright_analysis_path
-- 		end
-- 	end
-- end
--
--
-- -- setup pyright
-- lspconfig.pyright.setup({
-- 	on_attach = function(client, bufnr)
--
-- 		-- Read VScode launch.json and add PYTHONPATH
-- 		-- local f = vim.fn.filereadable("launch.json")
-- 		-- local file = io.open(".vscode/launch.json")
-- 		-- if (file ~= nil and vim.g.vscode_pythonpath == nil) then
-- 		-- 	-- local content = file:read "*a"
-- 		-- 	local lines = file:lines()
-- 		-- 	for line in lines do
-- 		-- 		line = line:gsub("%s+", "") -- https://www.lua.org/pil/20.2.html for lua patterns
-- 		-- 		-- print(line)
-- 		-- 		if line:find('^"PY') ~= nil then
-- 		-- 			line = line:gsub('"PYTHONPATH":', "")
-- 		-- 			local pythonpath = line:gsub('"', "")
-- 		-- 			if pythonpath ~= nil then
-- 		-- 				vim.env.PYTHONPATH = vim.env.PYTHONPATH .. ":" .. pythonpath
-- 		-- 				vim.g.vscode_pythonpath = 1
-- 		-- 			end
-- 		-- 		end
-- 		-- 	end
-- 		-- 	file:close()
-- 		-- end
--
-- 		if (vim.g.vscode_pythonpath ~= nil and vim.g.vscode_pythonpath_done == nil) then
-- 			vim.env.PYTHONPATH = vim.env.PYTHONPATH .. ":" .. vim.g.vscode_pythonpath
-- 			vim.g.vscode_pythonpath_done = 1
-- 		end
--
-- 		-- local handle = io.popen(command)
-- 		-- local result = handle:read("*a")
-- 		-- handle:close()
-- 		custom_attach(client, bufnr)
-- 	end,
-- 	flags = {
-- 		debounce_text_changes = nil,
-- 	},
-- 	settings = {
-- 		python = {
-- 			analysis = {
-- 				extraPaths = get_vscode_python_path(),
-- 				typeCheckingMode = "off"
-- 			}
-- 		}
-- 	}
-- })

lspconfig.pyright.setup({
	on_attach = custom_attach,
	flags = lsp_flags,
})

lspconfig.tsserver.setup({
	on_attach = custom_attach,
	flags = lsp_flags,
})
lspconfig.rust_analyzer.setup({
	on_attach = custom_attach,
	flags = lsp_flags,
	-- Server-specific settings...
	settings = {
		["rust-analyzer"] = {},
	},
})


lsp.setup()


-- lsp.setup_nvim_cmp
local cmp = require('cmp')

-- sources
cmp.setup({
  sources = {
    {name = 'nvim_lsp'},
    {name = 'buffer'},
	{ name = "vsnip" },
	{ name = "path" },
  }
})

-- basic keymaps
local cmp_select_opts = {behavior = cmp.SelectBehavior.Insert}
cmp.setup({
	mapping = cmp.mapping.preset.insert({
		['<c-d>'] = cmp.mapping.scroll_docs(-4),
		['<c-f>'] = cmp.mapping.scroll_docs(4),
		['<c-space>'] = cmp.mapping.complete(),
		['<c-e>'] = cmp.mapping.abort(),
		['<cr>'] = cmp.mapping.confirm({ select = true }), -- accept currently selected item. set `select` to `false` to only confirm explicitly selected items.
	}),
  })

-- super tab for snippets
local cmp_action = require('lsp-zero').cmp_action()
cmp.setup({
  mapping = {
    ['<Tab>'] = cmp_action.luasnip_supertab(),
    ['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),
  }
})

-- null-ls
-- https://github.com/LunarVim/Neovim-from-scratch/blob/master/lua/user/lsp/null-ls.lua
local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
    return
end

local formatting = null_ls.builtins.formatting
null_ls.setup({
    debug = true,
    sources = { -- stylua better than lua-format
    formatting.stylua,
    formatting.black.with({
        extra_args = {"-t", "py38", "-l", "96"}
    }) -- formatting.gofmt,
    }
})
