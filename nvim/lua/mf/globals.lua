local fmt = string.format

---Global namespace
---store all callbacks in one global table so they are able to survive re-requiring this file
_G.__mf_global_callbacks = __mf_global_callbacks or { }

_G.mf = {
    _store = __mf_global_callbacks,
}

---Add callback to global store
---@param f function
function mf._create(f)
    table.insert(mf._store, f)
    return #mf._store
end

---Execute callback with id
---@param id number
---@param args any
function mf._execute(id, args)
    mf._store[id](args)
end

---Create an autocommand
---@param name string
---@param commands Autocommand[]
function mf.augroup(name, commands)
    vim.cmd('augroup ' .. name)
    vim.cmd('autocmd!')
    for _, c in ipairs(commands) do
        local command = c.command
        if type(command) == 'function' then
            local fn_id = mf._create(command)
            command = fmt('lua mf._execute(%s)', fn_id)
        end
        vim.cmd(
            string.format(
                'autocmd %s %s %s %s',
                table.concat(c.events, ','),
                table.concat(c.targets or { }, ','),
                table.concat(c.modifiers or { }, ' '),
                command
            )
        )
    end
    vim.cmd('augroup END')
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

