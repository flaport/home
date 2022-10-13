local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
	return
end

lsp_installer.setup({
    automatic_installation = false, -- automatically detect which servers to install (based on which servers are set up via lspconfig)
    ui = {
        icons = {
            server_installed = "✓",
            server_pending = "➜",
            server_uninstalled = "✗"
        }
    }
})



-- -- Register a handler that will be called for each installed server when it's ready (i.e. when installation is finished
-- -- or if the server is already installed).
-- lsp_installer.on_server_ready(function(server)
-- 	local opts = {
-- 		on_attach = require("lsp.handlers").on_attach,
-- 		capabilities = require("lsp.handlers").capabilities,
-- 	}

-- 	-- (optional) Customize the options passed to the server
-- 	-- if server.name == "tsserver" then
-- 	--     opts.root_dir = function() ... end
-- 	-- end

-- 	-- lua
-- 	if server.name == "sumneko_lua" then
-- 		local lua_opt = {
-- 			settings = {
-- 				Lua = {
-- 					diagnostics = {
-- 						globals = { "vim" },
-- 					},
-- 					workspace = {
-- 						library = {
-- 							[vim.fn.expand("$VIMRUNTIME/lua")] = true,
-- 							[vim.fn.stdpath("config") .. "/lua"] = true,
-- 						},
-- 					},
-- 				},
-- 			},
-- 		}
-- 		opts = vim.tbl_deep_extend("force", lua_opt, opts)
-- 	end

-- 	local python_opt = {
-- 		settings = {},
-- 	}

-- 	-- This setup() function will take the provided server configuration and decorate it with the necessary properties
-- 	-- before passing it onwards to lspconfig.
-- 	-- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
-- 	server:setup(opts)
-- end)
