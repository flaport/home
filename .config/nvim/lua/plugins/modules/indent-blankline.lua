return {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
    enabled = true,
    config = function ()
        require("ibl").setup {
            debounce = 300,
            indent = { char = "╎" },
            exclude = { filetypes = {"help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "undotree"} },
            whitespace = {
                remove_blankline_trail = true,
            },
            scope = { enabled = false },
        }
    end
}
