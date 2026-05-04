local function config()
    vim.g.copilot_enabled = false
end

return {
    "github/copilot.vim",
    config = config,
}
