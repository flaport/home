require("pluginmanager")
require("fixed")
require("commands")
require("variables")
require("colors")
require("filetypes")
require("keybindings")

vim.cmd([[source ~/.config/nvim/vim/commands.vim ]])
vim.cmd([[source ~/.config/nvim/vim/keybindings.vim ]])
vim.cmd([[source ~/.config/nvim/vim/latex.vim ]])
vim.cmd([[source ~/.config/nvim/vim/neovim.vim ]])
vim.cmd([[source ~/.config/nvim/vim/python.vim ]])
vim.cmd([[source ~/.config/nvim/vim/rust.vim ]])
vim.cmd([[source ~/.config/nvim/vim/yaml.vim ]])

vim.asyncomplete_auto_completeopt = 0
vim.completeopt="menuone,noinsert,noselect,preview"
