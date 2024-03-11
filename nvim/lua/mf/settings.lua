local cmd = vim.cmd
local globals = require("mf.globals")

cmd('syntax enable')
cmd('filetype plugin indent on')

globals.augroup('UserSettings', {
        -- highlight yank for 250ms
        {
            event = { 'TextYankPost' },
            pattern = { '*' },
            command = function()
                vim.highlight.on_yank({ on_visual = false, timeout = 250 })
            end,
        },
       -- toggle hiding invisible chars on insert
        {
            event = { 'InsertEnter' },
            pattern = { '*' },
            command = function()
                vim.wo.list = false
            end,
        },
        {
            event = { 'InsertLeave' },
            pattern = { '*' },
            command = function()
                vim.wo.list = true
            end,
        },
        {
            event = { 'BufNewFile', 'BufRead'},
            pattern = { '*.tex' },
            command = function()
                vim.o.shiftwidth = 2
                vim.o.tabstop = 2
            end,
        },

        -- set tab width dynamically on c-like files
        {
            event = { 'FileType' },
            pattern = { 'c', 'cpp', 'sh', 'make' },
            command = function()
                vim.o.shiftwidth = 2
                vim.o.tabstop = 2
                vim.o.expandtab = false
            end,
        },
})

vim.o.title = true

vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.smartindent = true

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

vim.cmd('filetype plugin on')
