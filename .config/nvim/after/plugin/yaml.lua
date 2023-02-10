-- TODO: this autogroupg is not working, puting them in other conf files
-- works, but here is doens't. Not sure why
-- what it is mean to be: `autocmd BufNewFile,BufEnter,BufRead *.pic.yml call DetectSls()`
local group = vim.api.nvim_create_augroup("currently not working", { clear = true })
vim.api.nvim_create_autocmd(
    { "FileType" },
    { pattern = "yaml",
        command = "call DetectSls()",
        group = group })
vim.api.nvim_create_autocmd(
    { "BufNewFile,BufEnter,BufRead" },
    { pattern = "*.yml",
        -- command = "call DetectSls()",
        callback = function()
            local data = {
                buf = vim.fn.expand("<abuf>"),
                file = vim.fn.expand("<afile>"),
                match = vim.fn.expand("<amatch>"),
            }
            vim.schedule(function()
                print("hey")
                print(vim.inspect(data))
            end)
        end,
        group = group })


-- augroup yaml_sls
--     autocmd!
--     " autocmd BufNewFile,BufEnter,BufRead *.yml call DetectSls()
-- "     autocmd BufNewFile,BufEnter,BufRead *.pic.yml call DetectSls()
-- augroup end

