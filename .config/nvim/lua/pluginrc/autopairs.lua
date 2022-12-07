local cmp_status_ok, npair = pcall(require, "nvim-autopairs")
if not cmp_status_ok then
    return
end

npair.setup({
    enable_check_bracket_line = false, -- Don't add pairs if it already has a close pair in the same line
    ignored_next_char = "[%w%.]", -- Don't add pairs if the next char is alphanumeric, will ignore alphanumeric and `.` symbol
    fast_wrap = {  -- FastWrap, (|foobar      <C-w> then press $        (|foobar)
        map = '<C-w>'
    },
})


-- If you want insert `(` after select function or method item
local cmp = require('cmp')
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on(
    'confirm_done',
    cmp_autopairs.on_confirm_done()
)
