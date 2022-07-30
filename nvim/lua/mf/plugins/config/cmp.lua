local cmp = require('cmp')

cmp.setup {
  sources = {
      { name = 'nvim_lua' },
      { name = 'nvim_lsp' },
      { name = 'buffer', keyword_length = 4 },
      { name = 'path' },
  },

  mapping = cmp.mapping.preset.insert({
      ["<C-p>"] = cmp.mapping.select_prev_item(),
      ["<C-n>"] = cmp.mapping.select_next_item(),
      ['<C-Space>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),
}

