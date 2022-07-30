local M = { }

local silenced = { silent = true }

vim.g.mapleader = ','

-- clear highlight on space
mf.map('n', '<Space>', '<cmd>noh<CR>', silenced)

-- nerdtree
mf.map('n', '<C-t>', ':NERDTreeToggle<CR>', silenced)

-- line navigation
mf.map('n', 'ö', '^')
mf.map('n', 'ä', '$')
mf.map('n', 'dä', 'd$')
mf.map('n', 'dö', 'd^')
mf.map('n', 'yä', 'y$')
mf.map('n', 'yö', 'y^')
mf.map('v', 'ö', '^')
mf.map('v', 'ä', '$')

-- tab navigation
mf.map('n', '<Tab>', 'gt')
mf.map('n', '<S-Tab>', 'gT')

-- bash
mf.map('n', '<F1>','<C-w>s<C-w>j:terminal<CR>i')
mf.map('t', '<F1>','<C-\\><C-n>:q!<CR>')
mf.map('n', '<F2>','<C-w>ji')
mf.map('t', '<F2>','<C-\\><C-n><C-w>k')

-- telescope
mf.map('n', '<C-f><C-f>', ':Telescope find_files<CR>')
mf.map('n', '<C-f><C-g>', ':Telescope live_grep<CR>')

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
    buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', silenced)
    buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', silenced)
end

return M
