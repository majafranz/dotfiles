local cmd = vim.cmd

cmd('syntax enable')
cmd('filetype plugin indent on')

mf.augroup('UserSettings', {
        -- highlight yank for 250ms
        {
            events = { 'TextYankPost' },
            targets = { '*' },
            command = function()
                vim.highlight.on_yank({ on_visual = false, timeout = 250 })
            end,
        },
       -- toggle hiding invisible chars on insert
        {
            events = { 'InsertEnter' },
            targets = { '*' },
            command = function()
                vim.wo.list = false
            end,
        },
        {
            events = { 'InsertLeave' },
            targets = { '*' },
            command = function()
                vim.wo.list = true
            end,
        },
})

vim.o.title = true

vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.ts = 4
vim.o.sw = 4

vim.o.termguicolors = true
vim.o.shiftround = true
vim.o.hidden = true

vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.scrolloff = 4
vim.o.mouse = 'a'
vim.o.clipboard = 'unnamed,unnamedplus'
vim.o.showmode = false

vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = 'yes:1'
vim.o.list = true
vim.o.listchars = 'tab:→ ,trail:•,nbsp:␣,extends:»,precedes:«'
