local function config()
    require('nvim-treesitter.configs').setup {
        auto_install = false,
        ensure_installed = {
            'gitcommit',
            'diff',
            'git_rebase',
            'lua',
            'c',
            'python',
            'cpp',
            'make',
            'bash',
            'markdown',
            'markdown_inline',
        },
        -- A list of parser names
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false
        },
  }
  vim.opt.foldmethod="expr"
  vim.opt.foldexpr="nvim_treesitter#foldexpr()"
  vim.opt.foldlevel=10
end

return {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = config,
}
