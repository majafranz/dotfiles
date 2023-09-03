local servers = { 'clangd', 'texlab', 'jedi_language_server', 'r_language_server', 'lua_ls'}
local servers_wo_lua = { 'clangd', 'texlab', 'jedi_language_server', 'r_language_server'}

require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = servers
})

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(_, bufnr)
     require('mf.keymappings').lsp_mappings(bufnr)
end

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local lspconfig = require('lspconfig')

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
for _, lsp in ipairs(servers_wo_lua) do
    lspconfig[lsp].setup {
        on_attach = on_attach,
        capabilities = capabilities,
    }
end

-- Extra settings for Lua
require'lspconfig'.lua_ls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
    },
  },
}

