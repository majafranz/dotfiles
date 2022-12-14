local fmt = string.format

local mf = {}

---Create an autocommand
---returns the group ID so that it can be cleared or manipulated.
---@param name string
---@param commands Autocommand[]
---@return number
function mf.augroup(name, commands)
    local id = vim.api.nvim_create_augroup(name, { clear = true })

    for _, autocmd in ipairs(commands) do
        local is_callback = type(autocmd.command) == 'function'

        vim.api.nvim_create_autocmd(autocmd.event, {
            group = name,
            pattern = autocmd.pattern,
            desc = autocmd.description,
            callback = is_callback and autocmd.command or nil,
            command = not is_callback and autocmd.command or nil,
            once = autocmd.once,
            nested = autocmd.nested,
            buffer = autocmd.buffer,
        })
    end

    return id
end

---Set global vim keymap
---@param mode string
---@param lhs string
---@param rhs string
---@param opts table
function mf.map(mode, lhs, rhs, opts)
    local options = { noremap = true }

    if opts then
        options = vim.tbl_extend('force', options, opts)
    end

    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

---Set buffer vim keymap
---@param bufnr number
---@param mode string
---@param lhs string
---@param rhs string
---@param opts table
function mf.bmap(bufnr, mode, lhs, rhs, opts)
    local options = { noremap = true }

    if opts then
        options = vim.tbl_extend('force', options, opts)
    end

    vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, options)
end

return mf
