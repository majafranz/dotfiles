local M = { }

local silenced = { silent = true }

vim.g.mapleader = ','

-- clear highlight on space
mf.map('n', '<Space>', '<cmd>noh<CR>', silenced)

-- nerdtree
mf.map('n', '<C-t>', ':NERDTreeToggle<CR>', silenced)

-- line navigation
mf.map('n', 'ö', '^', silenced)
mf.map('n', 'ä', '$', silenced)
mf.map('n', 'dä', 'd$', silenced)
mf.map('n', 'dö', 'd^', silenced)
mf.map('n', 'yä', 'y$', silenced)
mf.map('n', 'yö', 'y^', silenced)
mf.map('v', 'ö', '^', silenced)
mf.map('v', 'ä', '$', silenced)

-- file navigation
mf.map('n', '<C-p>', '<C-i>', silenced)

-- pane navigation
mf.map('n', '<Right>', '<C-w>l', silenced)
mf.map('n', '<Left>', '<C-w>h', silenced)
mf.map('n', '<Up>', '<C-w>k', silenced)
mf.map('n', '<Down>', '<C-w>j', silenced)

-- tab navigation
mf.map('n', '<Tab>', 'gt', silenced)
mf.map('n', '<S-Tab>', 'gT', silenced)

-- terminal
mf.map('n', '<F1>','<C-w>s<C-w>j:terminal<CR><C-w>9-i', silenced)
mf.map('t', '<F1>','<C-\\><C-n>:q!<CR>', silenced)
mf.map('n', '<F2>','<C-w>ji', silenced)
mf.map('t', '<F2>','<C-\\><C-n><C-w>k', silenced)
mf.map('n', '<F3>','<C-w>v<C-w>l:terminal<CR>i', silenced)
mf.map('t', '<F3>','<C-\\><C-n><C-w>v<C-w>l:terminal<CR>i', silenced)
mf.map('t', '<C-o>','<C-\\><C-n>', silenced) -- get out of terminal wo closing

-- telescope
mf.map('n', '<C-f><C-f>', ':Telescope find_files<CR>', silenced)
mf.map('n', '<C-f><C-g>', ':Telescope live_grep<CR>', silenced)

-- neogen
mf.map('n', '<Space>n', ":lua require('neogen').generate()<CR>", silenced)

-- lsp
-- this function is passed to lsp's on_attach hook, so mappings are only loaded if lsp is
function M.lsp_mappings(bufnr)
    local function buf_set_keymap(...) mf.bmap(bufnr, ...) end

    -- most common lsp functions
    buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', silenced)
    buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', silenced)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', silenced)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', silenced)
    buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', silenced)
    buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', silenced)
    buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', silenced)
    buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', silenced)
    buf_set_keymap('n', '<Space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', silenced)
    buf_set_keymap('n', '<Space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', silenced)
    buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', silenced)
end

return M
