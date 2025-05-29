local style = require('mf.style')
local keymappings = require('mf.settings.keymappings')

local function config()
    local bc = style.current.border

    require('telescope').setup({
        defaults = {
            prompt_prefix = style.icons.ui.telescope .. ' ',
            -- telescope expects different order
            borderchars = { bc[2], bc[4], bc[6], bc[8], bc[1], bc[3], bc[5], bc[7] },
            set_env = { ['COLORTERM'] = 'truecolor' },
            mappings = {
                i = {
                    ['<c-c>'] = function()
                        vim.cmd('stopinsert!')
                    end,
                },
            },
            file_ignore_patterns = {
                '%.jpg', '%.jpeg', '%.png', '%.otf', '%.ttf', '%.o', '%.arxml', '%.dvg', '%.dll*', '%.exe', '%.defines', '%.jar',
            },
            layout_strategy = 'flex',
        },
    })
    keymappings.telescope_mappings()

    require('telescope').load_extension('fzf')
end

return {
    'nvim-telescope/telescope.nvim',
    config = config,
    dependencies = {
        'nvim-treesitter/nvim-treesitter',
        'nvim-lua/plenary.nvim',
        'kyazdani42/nvim-web-devicons',
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'make',
        },
    },
}
