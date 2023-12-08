local fn = vim.fn
local fmt = string.format
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

-- Auto install packer.nvim if not exists
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
end

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    use {
        'ellisonleao/gruvbox.nvim' ,
        tag = "0.1.0"
    }

    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
    }

    -- auto annotations
    use {
        'danymat/neogen',
        requires = 'nvim-treesitter/nvim-treesitter',
    }

    use 'lewis6991/gitsigns.nvim'
    use 'preservim/nerdtree'

    -- LSP support
    use "neovim/nvim-lspconfig"
    use "williamboman/mason.nvim"
    use "williamboman/mason-lspconfig.nvim"

    -- completion
    use {
        'hrsh7th/nvim-cmp',
        requires = {
          {'hrsh7th/cmp-buffer'},
          {'hrsh7th/cmp-path'},
          {'hrsh7th/cmp-nvim-lsp'},
          {'hrsh7th/cmp-nvim-lua'},
          {'L3MON4D3/LuaSnip'}
        },
    }

    -- syntax highlightig
    use 'lepture/vim-jinja' -- jinja

    -- fuzzy finder
    use {
        'nvim-telescope/telescope.nvim',
        requires = {
            'nvim-lua/plenary.nvim',
            'BurntSushi/ripgrep',
        },
        branch = '0.1.x'
    }

    use 'windwp/nvim-autopairs'

    -- obsidian
    use {
        "epwalsh/obsidian.nvim",
        tag = "*",  -- recommended, use latest release instead of latest commit
        requires = {
            -- Required.
            "nvim-lua/plenary.nvim",
        }
    }

    if packer_bootstrap then
        require('packer').sync()
    end
end)

