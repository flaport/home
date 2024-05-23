local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
	return
end

toggleterm.setup({
	-- size can be a number or function which is passed the current terminal
	size = function(term)
		if term.direction == "horizontal" then
			return math.floor(vim.o.lines * 0.23)
		elseif term.direction == "vertical" then
			return math.floor(vim.o.columns * 0.4)
		end
	end,
	open_mapping = [[<c-\>]],
	-- on_open = fun(t: Terminal), -- function to run when the terminal opens
	-- on_close = fun(t: Terminal), -- function to run when the terminal closes
	hide_numbers = false, -- hide the number column in toggleterm buffers
	-- shade_filetypes = {},
	start_in_insert = false,
	insert_mappings = true, -- whether or not the open mapping applies in insert mode
	persist_size = false,
	direction = "float", -- "vertical" | 'horizontal' | 'window' | 'float',
	close_on_exit = true, -- close the terminal window when the process exits
	-- shell = vim.o.shell, -- change the default shell
	-- -- This field is only relevant if direction is set to 'float'
	float_opts = {
		-- 	-- The border key is *almost* the same as 'nvim_open_win'
		-- 	-- see :h nvim_open_win for details on borders however
		-- 	-- the 'curved' border is a custom border type
		-- 	-- not natively supported but implemented in this plugin.
		border = "single", --'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
		width = function()
			return math.floor(vim.o.columns * 0.8)
		end,
		height = function()
			return math.floor(vim.o.lines * 0.8)
		end,
	},
})

local Terminal = require("toggleterm.terminal").Terminal


-- lazygit 7
local lazygit = Terminal:new({
	cmd = "lazygit",
	count = 7,
	direction = "float",
    close_on_exit = true,
	on_open = function(term)
		vim.cmd("startinsert!")
        local opts = {buffer = 0}
        vim.keymap.set('t', '<esc>', '<esc>', opts)
	end,
})
function _LAZZYGIT()
	lazygit:toggle()
end

-- python 9
local ipython = Terminal:new({
	count = 9,
	cmd = "ipython",
	on_open = function(term)
		vim.g.last_terminal_job_id = term.job_id
        -- vim.cmd([[execute "normal"]])
	end,
	on_exit = function()
		vim.g.last_terminal_job_id = nil
	end,
	hidden = false,
	direction = "horizontal" })

function _IPYTHON_TERM()
	ipython:toggle()
	vim.cmd([[execute "normal G\<C-w>k"]])
end

-- Run python in the neovim toggleterm terminal
function PythonRun(type)
    if vim.g.last_terminal_job_id ~= nil then
        vim.b.slime_config = { jobid = vim.g.last_terminal_job_id }
        if type == "celljump" then
            vim.cmd('IPythonCellExecuteCellJump')
        end
        if type == "runall" then
            vim.cmd('IPythonCellRunTime')
        end
    else
        vim.cmd([[call system('ipython -c "import sys"')]])
        -- print('not exist')
        if vim.v.shell_error == 0 then
            _IPYTHON_TERM()
            -- vim.wait(100)
            -- PythonRun(type)
        else
            print("ipython not found")
        end
    end
end

-- keymaps
local function set_python_related_keymaps()
    vim.keymap.set("n", "<CR>", function() PythonRun('celljump') end, { buffer = true })
    vim.keymap.set("n", "<F5>", function() PythonRun('runall') end, { buffer = true })
    vim.keymap.set("n", "<leader>\\", function() _IPYTHON_TERM() end, { buffer = true })
end

-- setting up the au group for the python filetype specific keymaps
local group_python = vim.api.nvim_create_augroup("custom_filetype_python", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
    pattern = "python",
    group = group_python,
    callback = set_python_related_keymaps
})