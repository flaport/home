local group = vim.api.nvim_create_augroup("helper_txt_nospell", { clear = true })
vim.api.nvim_create_autocmd(
    { "BufEnter" },
    { pattern = { "/usr/share/nvim/runtime/doc/*.txt" },
        command = "setlocal nospell",
        group = group })

