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
            add = { hl = 'GitSignsAdd'   , text = '▌' },
            change = { hl = 'GitSignsChange', text = '▌' },
            delete = { hl = 'GitSignsDelete', text = '▌' },
            topdelete = { hl = 'GitSignsDelete', text = '▌' },
            changedelete = { hl = 'GitSignsChange', text = '▌' },
        },
    },
}
