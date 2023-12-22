require("lazy").setup({
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',

    {
        'neovim/nvim-lspconfig',
        dependencies = {
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
            { 'j-hui/fidget.nvim', opts = {} },
        },
        'folke/neodev.nvim',
    },
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'VonHeikemen/lsp-zero.nvim',

    {
        'nvim-treesitter/nvim-treesitter',
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',
        },
        build = ':TSUpdate'
    },
    'nvim-treesitter/nvim-treesitter-context',

    'Yazeed1s/oh-lucy.nvim',
    {
        'nvim-lualine/lualine.nvim',
        opts = {
            options = {
                icons_enabled = false,
                theme = 'modus-vivendi',
                component_separators = "|",
                section_separators = '',
            },
        },
    },

    'github/copilot.vim',

    'romainl/vim-cool',
    {
        'ThePrimeagen/harpoon',
        branch = 'harpoon2',
        dependencies = {
            'nvim-lua/plenary.nvim',
        },
    },
    { 'dasupradyumna/midnight.nvim', lazy = false, priority = 1000 },

    { 'akinsho/toggleterm.nvim', version = "*", config = true },

    'rebelot/kanagawa.nvim',

    -- 'nvim-tree/nvim-tree.lua',
    'nvim-tree/nvim-web-devicons',
})

-- Colorscheme 
require('kanagawa').setup({
    transparent = false,
    colors = {
        theme = {
            all = {
                ui = {
                    bg_gutter = "none",
                },
            },
        }
    }
})

vim.cmd('colorscheme kanagawa-dragon')

-- Mason LSP Config
require('mason').setup()
require('mason-lspconfig').setup()

vim.defer_fn(function()
    require('nvim-treesitter.configs').setup {
        ensure_installed = { 'c','cpp','go','lua','python', 'rust', 'tsx', 'javascript', 'typescript', 'vimdoc', 'vim', 'bash' },

        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
    }
end, 0)

vim.cmd [[ set hlsearch ]]

local servers = {
    lua_ls = {
        Lua = {
            diagnostics = {
                globals = { 'vim' },
            },
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
        },
    },
}

local on_attach_mason = function(_, bufnr)
    local nmap = function(keys, func, desc)
        if desc then
            desc = 'LSP: ' .. desc
        end

        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
    end

    nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
    nmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')


    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        vim.lsp.buf.format()
    end, { desc = 'Format current buffer with LSP' })
end

local mason_lspconfig = require'mason-lspconfig'

mason_lspconfig.setup {
    ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
    function(server_name)
        require('lspconfig')[server_name].setup {
            on_attach = on_attach_mason,
            settings = servers[server_name],
            filetypes = (servers[server_name] or {}).filetypes,
        }
    end,
}

-- Nvim Tree Config 
local function on_attach_nvim_tree(_, bufnr)
    local api = require 'nvim-tree.api'

    local function opts(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    api.config.mappings.default_on_attach(bufnr)

    vim.keymap.set('n', "<Char-0xAA>", ":NvimTreeToggle<CR>", opts('Open and focus NvimTree'))
end

-- require('nvim-tree').setup {
    -- on_attach = on_attach_nvim_tree,
-- }
