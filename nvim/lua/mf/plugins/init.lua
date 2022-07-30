local fn = vim.fn
local fmt = string.format
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

-- Auto install packer.nvim if not exists
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
end

local function conf(name)
   return require(fmt('mf.plugins.config.%s', name))
end

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    use {
        'ellisonleao/gruvbox.nvim' ,
        config = conf('gruvbox')
    }

    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = conf('treesitter')
    }

    use {
        'lewis6991/gitsigns.nvim',
        config = conf('gitsigns')
    }

    use {
        'scrooloose/nerdtree',
    }

    -- LSP support
    use {
        'williamboman/nvim-lsp-installer',
        requires = {
          {'neovim/nvim-lspconfig'},
        },
        config = conf('lsp')
    }

    -- completion
    use {
        'hrsh7th/nvim-cmp',
        requires = {
          {'hrsh7th/cmp-buffer'},
          {'hrsh7th/cmp-path'},
          {'hrsh7th/cmp-nvim-lsp'},
          {'hrsh7th/cmp-nvim-lua'},
        },
        config = conf('cmp')
    }

    -- completion for python, as long as jedi-lsp is kinda shitty
    use {
        'Shougo/deoplete.nvim',
        run = ':UpdateRemotePlugins',
        config = conf('deoplete'),
    }
    use { 'zchee/deoplete-jedi' }

    -- fuzzy finder
    use {
        'nvim-telescope/telescope.nvim',
        requires = {
            'nvim-lua/plenary.nvim',
            'BurntSushi/ripgrep',
        },
        branch = '0.1.x'
    }
end)

