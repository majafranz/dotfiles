local function config()
    local to_be_intalled = {
        "stylua",
        "ruff",
    }

    require("null-ls").setup({
        ensure_installed = to_be_intalled,
        automatic_installation = true,
    })

    local none_ls = require("null-ls")

    none_ls.setup({
        sources = {}
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
