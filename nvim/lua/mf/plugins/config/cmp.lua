local cmp = require('cmp')

cmp.setup {
  sources = {
      { name = 'path', priority_weight = 110 },
      { name = 'nvim_lsp', max_item_count = 20, priority_weight = 100 },
      { name = 'nvim_lua', priority_weight = 90 },
      { name = 'buffer', priority_weight = 70, keyword_length = 4 },
  },

  mapping = cmp.mapping.preset.insert({
      ["<C-p>"] = cmp.mapping.select_prev_item(),
      ["<C-n>"] = cmp.mapping.select_next_item(),
      ['<C-Space>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),
}

