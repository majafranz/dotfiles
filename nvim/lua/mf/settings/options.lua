local cmd = vim.cmd

cmd('syntax enable')
cmd('filetype plugin indent on')

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
