local function config()
    local none_ls = require("null-ls")

    none_ls.setup({
        sources = {
            none_ls.builtins.formatting.black.with({
                extra_args = { "--line-length=80" },
            }),
        }
    })
end

return {
    'nvimtools/none-ls.nvim',
    event = 'VeryLazy',
    dependencies = 'nvim-lua/plenary.nvim',
    config = config
}
