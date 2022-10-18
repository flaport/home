require("globalsettings")
require("plugins")
require("pluginrc")
require("lsp")
require("playground")

vim.cmd([[
if filereadable(expand("~/.config/nvim/init_nvim.vim"))
    source ~/.config/nvim/init_nvim.vim
endif
]])

require("globalsettings_after")
