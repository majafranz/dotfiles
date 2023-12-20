local fmt = string.format

local M = {}

---Merge table t1, t2
---Source: https://stackoverflow.com/questions/1283388/lua-merge-tables
---@param t1 table
---@param t2 table
---@return table
function M.merge(t1, t2)
    for k, v in pairs(t2) do
        if (type(v) == 'table') and (type(t1[k] or false) == 'table') then
            M.merge(t1[k], t2[k])
        else
            t1[k] = v
        end
    end

    return t1
end

---@class Autocommand
---@field event  string[] list of autocommand events
---@field pattern string[] list of autocommand patterns
---@field command string | function

---Create an autocommand
---returns the group ID so that it can be cleared or manipulated.
---@param name string
---@param commands Autocommand[]
---@return number
function M.augroup(name, commands)
    local id = vim.api.nvim_create_augroup(name, { clear = true })

    for _, autocmd in ipairs(commands) do
        local is_callback = type(autocmd.command) == 'function'

        vim.api.nvim_create_autocmd(autocmd.event, {
            group = name,
            pattern = autocmd.pattern,
            callback = is_callback and autocmd.command or nil,
            command = not is_callback and autocmd.command or nil,
        })
    end

    return id
end

---Set global vim keymap
---@param mode string
---@param lhs string
---@param rhs string
---@param opts table
function M.map(mode, lhs, rhs, opts)
    local options = { noremap = true }

    if opts then
        options = M.merge(options, opts)
    end

    vim.keymap.set(mode, lhs, rhs, options)
end



return M
