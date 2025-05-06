return {
    'lewis6991/gitsigns.nvim',
    opts = {
        update_debounce = 50,
        current_line_blame_opts = {
            delay = 0,
        },
        preview_config = {
            border = require('mf.style').current.border,
        },
        signs = {
            add = { text = '▌' },
            change = { text = '▌' },
            delete = { text = '▌' },
            topdelete = { text = '▌' },
            changedelete = { text = '▌' },
        },
    },
}
