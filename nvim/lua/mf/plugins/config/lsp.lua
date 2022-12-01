require("nvim-lsp-installer").setup({
    automatic_installation = true, -- automatically detect which servers to install (based on which servers are set up via lspconfig)
})

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
     require('mf.keymappings').lsp_mappings(bufnr)
    -- Enable completion
--    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
--     -- See `:help vim.lsp.*` for documentation on any of the below functions
--     local bufopts = { noremap = true, silent = true, buffer = bufnr }
--     vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
--     vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
--     vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
--     vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
--     vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
--     vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
--     vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
--     vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
--     vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
--     vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)
end

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local lspconfig = require('lspconfig')

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
local servers = { 'clangd', 'texlab', 'sumneko_lua', 'jedi_language_server', 'r_language_server'}
for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
        on_attach = on_attach,
        capabilities = capabilities,
    }
end
