local M = {}

-- Function to find pyproject.toml in the current directory or parent directories
local function find_pyproject_toml()
    local current_dir = vim.fn.expand('%:p:h')
    
    while current_dir and current_dir ~= '/' do
        local pyproject_path = current_dir .. '/pyproject.toml'
        if vim.fn.filereadable(pyproject_path) == 1 then
            return pyproject_path
        end
        current_dir = vim.fn.fnamemodify(current_dir, ':h')
    end
    
    return nil
end

-- Function to parse pyproject.toml and extract ruff line-length
local function get_ruff_line_length(pyproject_path)
    local file = io.open(pyproject_path, 'r')
    if not file then
        return nil
    end
    
    local content = file:read('*all')
    file:close()
    
    -- Look for [tool.ruff] section and line-length setting
    local in_tool_ruff = false
    for line in content:gmatch('[^\r\n]+') do
        line = line:match('^%s*(.-)%s*$') -- trim whitespace
        
        if line == '[tool.ruff]' then
            in_tool_ruff = true
        elseif line:match('^%[') then
            -- New section started
            if not line:match('^%[tool%.ruff%.') then
                in_tool_ruff = false
            end
        elseif in_tool_ruff and line:match('^line%-length%s*=') then
            local length = line:match('line%-length%s*=%s*(%d+)')
            if length then
                return tonumber(length)
            end
        end
    end
    
    return nil
end

-- Main function to set Python colorcolumn
function M.set_python_colorcolumn()
    local default_length = 88
    local pyproject_path = find_pyproject_toml()

    if pyproject_path then
        local ruff_length = get_ruff_line_length(pyproject_path)
        if ruff_length then
            vim.opt_local.colorcolumn = tostring(ruff_length)
            vim.opt_local.textwidth = ruff_length
            return
        end
    end

    -- Default to 88 if no pyproject.toml or no ruff line-length setting
    vim.opt_local.colorcolumn = tostring(default_length)
    vim.opt_local.textwidth = default_length
end

return M 