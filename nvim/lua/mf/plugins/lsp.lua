local style = require('mf.style')

local lsp_list = {'texlab', 'pyright', 'lua_ls'}

local float_opts = {
    border = style.current.border,
    focusable = false,
    source = 'if_many',
    prefix = '',
    header = '',
}

local function diagnostics_config()
    vim.diagnostic.config({
        update_in_insert = false,
        virtual_text = false,
        severity_sort = true,
        float = float_opts,
    })

    -- setup diagnostic signs
    for type, icon in pairs(style.icons.lsp.signs) do
        type = type:sub(1, 1):upper() .. type:sub(2)
        local sign = 'DiagnosticSign' .. type
        local hl = 'Diagnostic' .. type

        vim.fn.sign_define(sign, { text = icon, texthl = hl, numhl = hl })
    end

    -- setup severity filter
    local ns = vim.api.nvim_create_namespace('diagonstic_severity_filter')
    local orig_signs_handler = vim.diagnostic.handlers.signs
    vim.diagnostic.handlers.signs = {
        show = function(_, bufnr, _, opts)
            local diagnostics = vim.diagnostic.get(bufnr)

            local max_severity_per_line = {}
            for _, d in pairs(diagnostics) do
                local m = max_severity_per_line[d.lnum]
                if not m or d.severity < m.severity then
                    max_severity_per_line[d.lnum] = d
                end
            end

            local filtered_diagnostics = vim.tbl_values(max_severity_per_line)
            orig_signs_handler.show(ns, bufnr, filtered_diagnostics, opts)
        end,
        hide = function(_, bufnr)
            orig_signs_handler.hide(ns, bufnr)
        end,
    }
end

local function cmp_config()
    local cmp = require('cmp')
    local luasnip = require('luasnip')

    local function tab(fallback)
        if cmp.visible() then
            cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
        elseif luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
        else
            fallback()
        end
    end

    local function shift_tab(fallback)
        if cmp.visible() then
            cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
        elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
        else
            fallback()
        end
    end

    cmp.setup({
        snippet = { expand = function(args) require('luasnip').lsp_expand(args.body) end },
        sources = {
            { name = 'path', priority_weight = 110 },
            { name = 'nvim_lsp', max_item_count = 20, priority_weight = 100 },
            { name = 'nvim_lua', priority_weight = 90 },
            { name = 'luasnip',  max_item_count = 5,  priority_weight = 90 },
            {
                name = 'rg',
                keyword_length = 5,
                max_item_count = 5,
                priority_weight = 80,
                option = {
                    additional_arguments = '--smart-case --max-depth 8',
                },
            },
            { name = 'buffer', priority_weight = 70, keyword_length = 4 },
        },
        sorting = {
            priority_weight = 1.0,
            comparators = {
                cmp.config.compare.offset,
                cmp.config.compare.exact,
                cmp.config.compare.score,
                cmp.config.compare.kind,
                cmp.config.compare.sort_text,
                cmp.config.compare.length,
                cmp.config.compare.order,
            },
        },
        mapping = {
            ["<C-p>"] = cmp.mapping.select_prev_item(),
            ["<C-n>"] = cmp.mapping.select_next_item(),
            ['<C-Space>'] = cmp.mapping.abort(),
            ['<CR>'] = cmp.mapping.confirm({ select = true }),
            ["<C-l>"] = cmp.mapping(tab),
            ["<C-h>"] = cmp.mapping(shift_tab),
            ['<C-u>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
            ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
            ['<C-q>'] = cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close() }),
        },

        window = {
            completion = {
                winhighlight = 'FloatBorder:Pmenu,Search:None',
                col_offset = -3,
                side_padding = 0,
            },
        },
        formatting = {
            fields = { 'kind', 'abbr', 'menu' },
            format = function(entry, vim_item)
                print(entry.source.name)
                local menu = ({
                    nvim_lsp = '(LSP)',
                    path = '(Path)',
                    luasnip = '(SN)',
                    buffer = '(B)',
                    cmdline = '(Cmd)',
                    rg = '(Rg)',
                    obsidian_new = '(CR)',
                    obsidian = '(OB)',
                })[entry.source.name]
                vim_item.menu = '(' .. vim_item.kind .. ') ' .. menu
                vim_item.kind = string.format(' %s ', style.icons.lsp.kinds[vim_item.kind])

                return vim_item
            end,
        },
    })

    -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
            { name = 'buffer' },
        },
        view = {
            entries = { name = 'wildmenu', separator = '|' },
        },
    })
    -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
            { name = 'cmdline', keyword_pattern = [=[[^[:blank:]\!]*]=] },
            { name = 'path' },

        }),
        view = {
            entries = { name = 'wildmenu', separator = '|' },
        },
    })

    require('luasnip.loaders.from_vscode').lazy_load()
end

local function lsp_config()
    local lspconfig = require('lspconfig')

    -- Add additional capabilities supported by nvim-cmp
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
    local lsp_attach = function(_, bufnr)
        require('mf.keymappings').lsp_mappings({ buffer = bufnr })
    end

    vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, float_opts)

    require('mason-lspconfig').setup({ ensure_installed = lsp_list })
    require('mason-lspconfig').setup_handlers({
        function(server_name)
            lspconfig[server_name].setup({
                on_attach = lsp_attach,
                capabilities = lsp_capabilities,
            })
        end,
        ['lua_ls'] = function()
            lspconfig['lua_ls'].setup({
                on_attach = lsp_attach,
                capabilities = lsp_capabilities,
                settings = {
                    Lua = {
                      diagnostics = {
                        -- Get the language server to recognize the `vim` global
                        globals = {'vim'},
                      },
                    },
                },
            })
        end,
        ['clangd'] = function()
            lspconfig.clangd.setup({
                on_attach = lsp_attach,
                capabilities = lsp_capabilities,
                cmd = {"clangd", "--compile-commands-dir=" .. vim.loop.cwd() },
                filetypes = { "c", "cpp", "objc", "objcpp", "arduino" },
                init_options = {
                    usePlaceholders = true,
                    completeUnimported = true,
                },
            })
        end
    })
end

return {
    {
        'neovim/nvim-lspconfig',
        config = function()
            diagnostics_config()
            cmp_config()
            lsp_config()
        end,
        dependencies = {
            -- LSP Support
            {
                'williamboman/mason.nvim',
                opts = {
                    ui = {
                        icons = {
                            package_installed = style.icons.lsp.mason.installed,
                            package_pending = style.icons.lsp.mason.pending,
                            package_uninstalled = style.icons.lsp.mason.uninstalled,
                        },
                    },
                }
            },
            { 'williamboman/mason-lspconfig.nvim' },

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },
            { 'L3MON4D3/LuaSnip' },
            -- optional sources
            { 'hrsh7th/cmp-path' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-cmdline' },
            { 'lukas-reineke/cmp-rg' },
        },
    }
}
