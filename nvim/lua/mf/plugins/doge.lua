local function config()
    vim.g.doge_doc_standard_python = 'sphinx'
    vim.g.doge_python_settings = "{'single_quotes': 0, 'omit_redundant_param_types': 0}"
end

return {
    "kkoomen/vim-doge",
    build = ':call doge#install()',
    config = config,
}
