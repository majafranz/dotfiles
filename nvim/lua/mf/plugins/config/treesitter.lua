require('nvim-treesitter.configs').setup({
    -- A list of parser names
    ensure_installed = { "c", "lua", "python", "cpp", "make", "rust", "bash", "yaml"},

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = true,
    highlight = {
        enable = true,
   },
})

vim.opt.foldmethod="expr"
vim.opt.foldexpr="nvim_treesitter#foldexpr()"
vim.opt.foldlevel=10

