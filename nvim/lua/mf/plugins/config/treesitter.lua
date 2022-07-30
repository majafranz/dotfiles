vim.cmd([[
    set foldmethod=expr
    set foldexpr=nvim_treesitter#foldexpr()
    set nofoldenable
]])

return require('nvim-treesitter.configs').setup({
    ensure_installed = { "c", "lua", "python"},
    highlight = {
        enable = true,
   },
})


