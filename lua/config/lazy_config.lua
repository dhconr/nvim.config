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
                theme = 'iceberg_dark',
                component_separators = "|",
                section_separators = '',
            },
        },
    },

    -- {
    --     'github/copilot.vim',
    --     lazy = false,
    --     config = function()
    --         vim.g.copilot_no_tab_map = true;
    --         vim.g.copilot_assume_mapped = true;
    --         vim.g.copilot_tab_fallback = "";
    --     end
    -- },

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

    {
        'mrcjkb/haskell-tools.nvim',
        lazy = false,
        version = '^3', -- Recommended
        ft = { 'haskell', 'lhaskell', 'cabal', 'cabalproject' },
    },
    'neovimhaskell/haskell-vim',
    { 'echasnovski/mini.comment', version = false },
    { 'echasnovski/mini.surround', version = false },

    -- Autocompletion
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',

            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-path',
        },
    },

    -- Color schemes
    'EdenEast/nightfox.nvim',
    'JoosepAlviste/palenightfall.nvim',
    'lewpoly/sherbet.nvim',

    {
        'olimorris/onedarkpro.nvim',
        priority = 1000
    },

    -- File tree
    {
        'nvim-telescope/telescope-file-browser.nvim',
        dependencies = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' },
    },
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
-- vim.cmd('colorscheme duskfox')
-- vim.cmd('colorscheme palenightfall')
-- string = #ccb88f
-- vim.cmd('colorscheme sherbet')
-- vim.cmd('colorscheme onedark_dark')

-- Mini Surround && Comment Config
require('mini.surround').setup()
require('mini.comment').setup()

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
    nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    nmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')


    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        vim.lsp.buf.format()
    end, { desc = 'Format current buffer with LSP' })
end

local mason_lspconfig = require'mason-lspconfig'

mason_lspconfig.setup {
    ensure_installed = vim.tbl_keys(servers),
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

mason_lspconfig.setup_handlers {
    function(server_name)
        require('lspconfig')[server_name].setup {
            capabilities = capabilities,
            on_attach = on_attach_mason,
            settings = servers[server_name],
            filetypes = (servers[server_name] or {}).filetypes,
        }
    end,
}

-- Suppress warning: multiple different client offset_encodings detected for buffer, this is not supported yet
local notify = vim.notify
vim.notify = function(msg, ...)
    if msg:find('warning: multiple different client offset_encodings') then
        return
    end

    notify(msg, ...)
end

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

-- Completion config

local cmp = require 'cmp'
local luasnip = require 'luasnip'
require('luasnip.loaders.from_vscode').lazy_load()
luasnip.config.setup {}

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  preselect = 'none',
  completion = {
    completeopt = 'menu,menuone,noinsert,noselect',
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete {},
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    -- ['<S-Tab>'] = cmp.mapping(function(fallback)
    --   if cmp.visible() then
    --     cmp.select_prev_item()
    --   elseif luasnip.locally_jumpable(-1) then
    --     luasnip.jump(-1)
    --   else
    --     fallback()
    --   end
    -- end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp' },
  },
}

vim.api.nvim_set_keymap("i", "<S-Tab>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
