local function config()
    -- Default options:
    require("gruvbox")
    vim.cmd("colorscheme gruvbox")
end

return {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = config,
}
