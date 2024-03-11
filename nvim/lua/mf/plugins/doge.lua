local function config()
    vim.g.doge_doc_standard_python = 'sphinx'
end

return {
    "kkoomen/vim-doge",
    tag = "v4.6.3",
    build = ':call doge#install()',
    config = config,
}
