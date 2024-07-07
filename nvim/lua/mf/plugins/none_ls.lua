local function config()
    local to_be_intalled = {
        "stylua",
        "mypy",
        "ruff",
        "black",
    }

    require("mason-null-ls").setup({
        ensure_installed = to_be_intalled,
        automatic_installation = true,
    })

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
    "nvimtools/none-ls.nvim",
    config = config,
    dependencies = {
        "nvim-lua/plenary.nvim",
        "jay-babu/mason-null-ls.nvim",
    }
}
