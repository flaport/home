return {
    "nvim-lualine/lualine.nvim",
    enabled = true,
    lazy = false,
    event = { "BufReadPost", "BufNewFile" },
    config = function()
        require("lualine").setup {
            options = {
                theme = "auto",
                icons_enabled = true,
                section_separators = "",
                component_separators = "",
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = { "branch" },
                lualine_c = {
                    -- "filename",
                    {
                        "filetype",
                        icon_only = true,
                        separator = "",
                        padding = {
                            left = 1, right = 0 }
                    },
                    { "filename",    path = 1,                 symbols = { modified = "  ", readonly = "", unnamed = "" } },
                    { "diagnostics", sources = { "nvim_lsp" }, symbols = { error = " ", warn = " ", info = " " } },
                },
                lualine_x = { "encoding" },
                lualine_y = { "progress" },
                lualine_z = {
                    function()
                        return " " .. os.date("%R")
                    end,
                },
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { "filename" },
                lualine_x = { "location" },
                lualine_y = {},
                lualine_z = {},
            },
            tabline = {},
            extensions = { "neo-tree", "lazy" },
        }
    end,
}
