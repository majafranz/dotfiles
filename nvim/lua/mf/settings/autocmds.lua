local globals = require("mf.settings.globals")

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
                vim.o.expandtab = true
            end,
        },

        -- set tab width dynamically on c-like files
        {
            event = { 'FileType' },
            pattern = { 'c', 'cpp', 'sh', 'make', "arduino"},
            command = function()
                vim.o.shiftwidth = 2
                vim.o.tabstop = 2
                vim.o.expandtab = false
            end,
        },
        -- set tab width dynamically on vue and ts files
        {
            event = { 'FileType' },
            pattern = {"vue", "ts"},
            command = function()
                vim.o.shiftwidth = 4
                vim.o.tabstop = 4
                vim.o.expandtab = false
            end,
        },
})
