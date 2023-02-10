require("pluginmanager")
require("telescope.builtin")
require("fixed")
require("commands")
require("keybindings")
require("colors")

-- require("variables") -- we're using regular .vim file for this...
vim.cmd([[source ~/.config/nvim/vim/variables.vim ]])
vim.cmd([[source ~/.config/nvim/vim/plugin_settings.vim ]])
vim.cmd([[source ~/.config/nvim/vim/other_settings.vim ]])
