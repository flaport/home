local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
	return
end

require("lsp.lsp-installer")
require("lsp.null-ls")



local updated_capabilities = vim.lsp.protocol.make_client_capabilities()
updated_capabilities = require("cmp_nvim_lsp").update_capabilities(updated_capabilities)

local custom_attach = function(client)
	local filetype = vim.api.nvim_buf_get_option(0, "filetype")

	--   if nvim_status then
	--     nvim_status.on_attach(client)
	--   end
	vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = true })
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = true })
	vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, { buffer = true })
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = true })
	vim.keymap.set("n", "<leader>dn", vim.diagnostic.goto_next, { buffer = true })
	vim.keymap.set("n", "<leader>dp", vim.diagnostic.goto_prev, { buffer = true })
	vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { buffer = true })
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = true })

	--   buf_inoremap { "<c-s>", vim.lsp.buf.signature_help }
	--   buf_nnoremap { "gD", vim.lsp.buf.declaration }
	--   buf_nnoremap { "<space>gI", handlers.implementation }
	--   buf_nnoremap { "<space>lr", "<cmd>lua R('tj.lsp.codelens').run()<CR>" }
	--   buf_nnoremap { "<space>rr", "LspRestart" }
	--   telescope_mapper("gr", "lsp_references", nil, true)
	--   telescope_mapper("gI", "lsp_implementations", nil, true)
	--   telescope_mapper("<space>wd", "lsp_document_symbols", { ignore_filename = true }, true)
	--   telescope_mapper("<space>ww", "lsp_dynamic_workspace_symbols", { ignore_filename = true }, true)
	--   if filetype ~= "lua" then
	--     buf_nnoremap { "K", vim.lsp.buf.hover, { desc = "lsp:hover" } }

	vim.schedule(function() print("LSP is ready") end)

	vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"

	-- hightlight current word
	if client.server_capabilities.documentHighlightProvider then
		vim.cmd [[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]]
	end
end




-- An example of configuring for `sumneko_lua`,
--  a language server for Lua.
lspconfig.sumneko_lua.setup({
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
	capabilities = updated_capabilities
})


-- setup pyright
lspconfig.pyright.setup({
	on_attach = function(client)

		if (vim.g.vscode_pythonpath ~= nil and vim.g.vscode_pythonpath_done == nil) then
			vim.env.PYTHONPATH = vim.env.PYTHONPATH .. ":" .. vim.g.vscode_pythonpath
			vim.g.vscode_pythonpath_done = 1
		end

		-- local handle = io.popen(command)
		-- local result = handle:read("*a")
		-- handle:close()
		custom_attach(client)
	end,
	capabilities = updated_capabilities,
	flags = {
		debounce_text_changes = nil,
	}
})

-- other language servers
local servers = {
	-- pyright = true,

	-- rust
	rust_analyzer = true,

	-- go
	gopls = {
		settings = {
			gopls = {
				gofumpt = true
			}
		}
	}
}


local setup_server = function(server, config)
	if not config then
		return
	end

	if type(config) ~= "table" then
		config = {}
	end

	config = vim.tbl_deep_extend("force", {
		-- on_init = custom_init,
		on_attach = custom_attach,
		capabilities = updated_capabilities,
		flags = {
			debounce_text_changes = nil,
		},
	}, config)

	lspconfig[server].setup(config)
end

for server, config in pairs(servers) do
	setup_server(server, config)
end

