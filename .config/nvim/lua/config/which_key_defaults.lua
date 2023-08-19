return {
    mode = { "n", "v" },
    [";"] = { ":Alpha<CR>", "Dashboard" },
    w = { ":w!<CR>", "Save" },
    q = { ":confirm q<CR>", "Quit" },
    c = { ":bd<CR>", "Close Buffer" },
    h = { ":nohlsearch<CR>", "No Highlight" },
    p = { ":Lazy<CR>", "Lazy" },
    f = { ':Telescope find_files<CR>', "Find Files" },
    r = { function() require("spectre").open() end, "Replace (Spectre)" },
    o = {'<cmd>SymbolsOutline<CR>', "Outline"},
    b = {
        name = "Buffers",
        j = { "<cmd>BufferLinePick<cr>", "Jump" },
        f = { "<cmd>Telescope buffers previewer=false<cr>", "Find" },
        b = { "<cmd>BufferLineCyclePrev<cr>", "Previous" },
        n = { "<cmd>BufferLineCycleNext<cr>", "Next" },
        W = { "<cmd>noautocmd w<cr>", "Save without formatting (noautocmd)" },
        e = {
            "<cmd>BufferLinePickClose<cr>",
            "Pick which buffer to close",
        },
        h = { "<cmd>BufferLineCloseLeft<cr>", "Close all to the left" },
        l = {
            "<cmd>BufferLineCloseRight<cr>",
            "Close all to the right",
        },
        D = {
            "<cmd>BufferLineSortByDirectory<cr>",
            "Sort by directory",
        },
        L = {
            "<cmd>BufferLineSortByExtension<cr>",
            "Sort by language",
        },
        p = { "<cmd>BufferLineTogglePin<CR>", "Toggle pin" },
        P = { "<cmd>BufferLineGroupClose ungrouped<CR>", "Delete non-pinned buffers" },
    },
    G = {
        name = "+Git",
        j = { "<cmd>lua require 'gitsigns'.next_hunk({navigation_message = false})<cr>", "Next Hunk" },
        k = { "<cmd>lua require 'gitsigns'.prev_hunk({navigation_message = false})<cr>", "Prev Hunk" },
        l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
        p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
        r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
        R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
        s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
        u = {
            "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
            "Undo Stage Hunk",
        },
        o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
        b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
        c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
        C = {
            "<cmd>Telescope git_bcommits<cr>",
            "Checkout commit(for current file)",
        },
        d = {
            "<cmd>Gitsigns diffthis HEAD<cr>",
            "Git Diff",
        },
    },
    l = {
        name = "+LSP",
        a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
        d = { "<cmd>lua vim.lsp.buf.definition()<cr>", "Definition" },
        D = { "<cmd>lua vim.lsp.buf.declaration()<cr>", "Declaration" },
        i = { "<cmd>lua vim.lsp.buf.implementation()<cr>", "Implementation" },
        o = { "<cmd>lua vim.lsp.buf.type_definition()<cr>", "Type Definition" },
        R = { "<cmd>lua vim.lsp.buf.references()<cr>", "References" },
        s = { "<cmd>lua vim.lsp.buf.signature_help()<cr>", "Display Signature Information" },
        r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename all references" },
        f = { "<cmd>lua vim.lsp.buf.format()<cr>", "Format" },
        K = { "<cmd>lua vim.lsp.buf.hover()<cr>", "Hover" },
        -- l = { "<cmd>lua vim.lsp.diagnostic.open_float()<cr>", "Show Line Diagnostics" },
        l = { "<cmd>TroubleToggle document_diagnostics<cr>", "Document Diagnostics (Trouble)" },
        L = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "Workspace Diagnostics (Trouble)" },
        w = { "<cmd>Telescope diagnostics<cr>", "Diagnostics" },
        p = {
            name = "+LspSaga",
            -- LSP finder - Find the symbol's definition
            -- If there is no definition, it will instead be hidden
            -- When you use an action in finder like "open vsplit",
            -- you can use <C-t> to jump back
            h = { "<cmd>Lspsaga lsp_finder<CR>", "LSP Finder" },
            p = { "<cmd>Lspsaga peek_definition<CR>", "Peek Definition" },
            t = { "<cmd>Lspsaga peek_type_definition<CR>", "Peek Type Definition" },
            o = { "<cmd>Lspsaga outline<CR>", "Outline" },
        },
        -- j = { "<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>", "Previous Diagnostic" },
        -- k = { "<cmd>lua vim.lsp.diagnostic.goto_next()<cr>", "Next Diagnostic" },
        -- e = { "<cmd>Telescope quickfix<cr>", "Telescope Quickfix" },
    },
    s = {
        name = "+Search",
        b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
        f = { "<cmd>Telescope find_files<cr>", "Find File" },
        h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
        H = { "<cmd>Telescope highlights<cr>", "Find highlight groups" },
        M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
        r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
        R = { "<cmd>Telescope registers<cr>", "Registers" },
        t = { "<cmd>Telescope live_grep<cr>", "Text" },
        k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
        C = { "<cmd>Telescope commands<cr>", "Commands" },
        l = { "<cmd>Telescope resume<cr>", "Resume last search" },
    },
    t = {
        name = "+Todo",
        t = { "<cmd>TodoTelescope<cr>", "Todo" },
        T = { "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", "Todo/Fix/Fixme" },
        x = { "<cmd>TodoTrouble<cr>", "Todo (Trouble)" },
        X = { "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr><cr>", "Todo/Fix/Fixme (Trouble)" },
    }
}
