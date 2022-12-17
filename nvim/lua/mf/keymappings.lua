local M = {}

local globals = require("mf.globals")

local silenced = { silent = true }

vim.g.mapleader = ' '

-- clear highlight on space
globals.map('n', '<space>', '<cmd>noh<CR>', silenced)

-- nerdtree
globals.map('n', '<C-t>', ':NERDTreeToggle<CR>', silenced)

-- line navigation
globals.map('n', 'ö', '^', silenced)
globals.map('n', 'ä', '$', silenced)
globals.map('n', 'dä', 'd$', silenced)
globals.map('n', 'dö', 'd^', silenced)
globals.map('n', 'yä', 'y$', silenced)
globals.map('n', 'yö', 'y^', silenced)
globals.map('v', 'ö', '^', silenced)
globals.map('v', 'ä', '$', silenced)

-- file navigation
globals.map('n', '<C-p>', '<C-i>', silenced)

-- pane navigation
globals.map('n', '<Right>', '<C-w>l', silenced)
globals.map('n', '<Left>', '<C-w>h', silenced)
globals.map('n', '<Up>', '<C-w>k', silenced)
globals.map('n', '<Down>', '<C-w>j', silenced)

-- tab navigation
globals.map('n', '<Tab>', 'gt', silenced)
globals.map('n', '<S-Tab>', 'gT', silenced)

-- terminal
globals.map('n', '<F1>','<C-w>s<C-w>j:terminal<CR><C-w>9-i', silenced)
globals.map('t', '<F1>','<C-\\><C-n>:q!<CR>', silenced)
globals.map('n', '<F2>','<C-w>ji', silenced)
globals.map('t', '<F2>','<C-\\><C-n><C-w>k', silenced)
globals.map('n', '<F3>','<C-w>v<C-w>l:terminal<CR>i', silenced)
globals.map('t', '<F3>','<C-\\><C-n><C-w>v<C-w>l:terminal<CR>i', silenced)
globals.map('t', '<C-o>','<C-\\><C-n>', silenced) -- get out of terminal wo closing

-- telescope
globals.map('n', '<C-f><C-f>', ':Telescope find_files<CR>', silenced)
globals.map('n', '<C-f><C-g>', ':Telescope live_grep<CR>', silenced)

-- neogen
globals.map('n', '<leader>n', ":lua require('neogen').generate()<CR>", silenced)

-- lsp
-- this function is passed to lsp's on_attach hook, so mappings are only loaded if lsp is
function M.lsp_mappings(bufnr)

    local function buf_set_keymap(...) globals.bmap(bufnr, ...) end
    -- most common lsp functions
    buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', silenced)
    buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', silenced)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', silenced)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', silenced)
    buf_set_keymap('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', silenced)
    buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', silenced)
    buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', silenced)
    buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', silenced)
    buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', silenced)
    buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', silenced)
    buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', silenced)
    buf_set_keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', silenced)
end

return M
