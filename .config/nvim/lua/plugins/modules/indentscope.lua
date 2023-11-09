return {
    "echasnovski/mini.indentscope",
    version = false,
    enabled = true,
    event = { "BufReadPre", "BufNewFile" },
    opts = {
        symbol = "┃",
        options = { try_as_border = true },
        draw = {
            delay = 50, -- Delay (in ms) between event and start of drawing scope indicator
        },
    },
    init = function()
        vim.api.nvim_create_autocmd("FileType", {
            pattern = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "mason", "undotree" },
            callback = function()
                vim.b.miniindentscope_disable = true
            end,
        })
    end,
    config = function(_, opts)
        require("mini.indentscope").setup(opts)
    end,
}
