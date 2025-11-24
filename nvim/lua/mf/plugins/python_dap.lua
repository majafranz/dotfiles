local function config()
    require("dap-python").setup("python")
end

return {
    "mfussenegger/nvim-dap-python",
    config = config,
    dependencies = {
        "mfussenegger/nvim-dap",
    }
}
