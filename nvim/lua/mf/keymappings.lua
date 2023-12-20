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
globals.map('n', '<F1>','<C-w>s<C-w>j:terminal<CR><C-w>20-i', silenced)
globals.map('t', '<F1>','<C-\\><C-n>:q!<CR>', silenced)
globals.map('n', '<F2>','<C-w>ji', silenced)
globals.map('t', '<F2>','<C-\\><C-n><C-w>k', silenced)
globals.map('n', '<F3>','<C-w>v<C-w>l:terminal<CR>i', silenced)
globals.map('t', '<F3>','<C-\\><C-n><C-w>v<C-w>l:terminal<CR>i', silenced)
globals.map('t', '<C-o>','<C-\\><C-n>', silenced) -- get out of terminal wo closing

-- neogen
globals.map('n', '<leader>n', ":lua require('neogen').generate()<CR>", silenced)

-- obsidian
globals.map('n', '<leader>oo', ":ObsidianOpen<CR>", silenced)
globals.map('n', '<leader>ot', ":ObsidianToday<CR>", silenced)
globals.map('n', '<leader>oy', ":ObsidianYesterday<CR>", silenced)
globals.map('n', '<leader>om', ":ObsidianTomorrow<CR>", silenced)
globals.map('n', '<leader>os', ":ObsidianQuickSwitch<CR>", silenced)

-- gitsigns
globals.map('n', '<leader>gn', ':Gitsigns next_hunk<CR>', silenced)
globals.map('n', '<leader>gp', ':Gitsigns prev_hunk<CR>', silenced)
globals.map('n', '<leader>gs', ':Gitsigns preview_hunk<CR>', silenced)
globals.map('n', '<leader>gr', ':Gitsigns reset_hunk<CR>', silenced)
globals.map('n', '<leader>gd', ':Gitsigns diffthis<CR>', silenced)
globals.map('n', '<leader>ga', ':Gitsigns stage_hunk<CR>', silenced)
globals.map('n', '<leader>gu', ':Gitsigns undo_stage_hunk<CR>', silenced)

-- lsp
-- this function is passed to lsp's on_attach hook, so mappings are only loaded if lsp is
function M.lsp_mappings(opts)
    opts = globals.merge(opts, silenced)

    -- most common lsp functions
    globals.map('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    globals.map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    globals.map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    globals.map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    globals.map('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
    globals.map('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
    globals.map('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
    globals.map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    globals.map('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    globals.map('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    globals.map('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    globals.map('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

function M.telescope_mappings()
    -- telescope
    globals.map('n', '<C-f><C-f>', ':Telescope find_files<CR>', silenced)
    globals.map('n', '<C-f><C-g>', ':Telescope live_grep<CR>', silenced)
end

return M

