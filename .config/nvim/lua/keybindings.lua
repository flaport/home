require("commands")

local telescope = require("telescope.builtin")

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex) -- ***
vim.keymap.set("n", "<leader>ff", telescope.find_files, {})
vim.keymap.set("n", "<leader>fg", telescope.live_grep, {})
vim.keymap.set("n", "<leader>fb", telescope.buffers, {})
vim.keymap.set("n", "<leader>fh", telescope.help_tags, {})
vim.keymap.set("n", "<leader>ps", function()
	telescope.grep_string({ search = vim.fn.input("Grep > ") })
end)
vim.keymap.set("n", "<C-p>", telescope.git_files, {})
