function get_config(name)
    return string.format('require("config/%s")', name)
end

return require("lazy").setup({
    defaults = {
        lazy = false,
    },
    { "github/copilot.vim" },
    {
        "olimorris/onedarkpro.nvim",
        lazy = false,
        config = function()
            require("config/onedark")
            vim.cmd([[colorscheme onedark]])
        end,
    },
    { "github/copilot.vim" },
    {
        "amitds1997/remote-nvim.nvim",
        version = "*",                       -- Pin to GitHub releases
        dependencies = {
            "nvim-lua/plenary.nvim",         -- For standard functions
            "MunifTanjim/nui.nvim",          -- To build the plugin UI
            "nvim-telescope/telescope.nvim", -- For picking b/w different remote methods
        },
        config = function()
            require("config/remote")
        end,
    },
    {
        "nvimtools/none-ls.nvim",
        dependencies = {
            "nvimtools/none-ls-extras.nvim",
        },
        config = function()
            require("config/nullls")
        end,
    },
    { "tpope/vim-sleuth" },
    { "stevearc/dressing.nvim" },
    {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    },
    {
        "folke/which-key.nvim",
        dependencies = { "echasnovski/mini.icons" },
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        opts = {
            triggers = { "<leader>" }
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        }
    },
    {
        'romgrk/barbar.nvim',
        dependencies = {
            'lewis6991/gitsigns.nvim',     -- OPTIONAL: for git status
            'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
        },
        init = function() vim.g.barbar_auto_setup = false end,
        opts = {
            -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
            -- animation = true,
            -- insert_at_start = true,
            -- …etc.
        },
        version = '^1.0.0', -- optional: only update when a new 1.x version is released
    },
    {
        "L3MON4D3/LuaSnip",
        config = function()
            require("config/luasnip")
        end,
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lua",
            "hrsh7th/cmp-calc",
            "hrsh7th/cmp-nvim-lsp-signature-help",
        },
        config = function()
            require('config/completion')
        end,
    },
    { "saadparwaiz1/cmp_luasnip" },
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/popup.nvim",
            "nvim-lua/plenary.nvim"
        },
    },
    {
        "williamboman/mason.nvim",
        config = function()
            require("config/mason")
        end,
    },
    { "williamboman/mason-lspconfig.nvim" },
    { "neovim/nvim-lspconfig" },
    {
        "nvim-treesitter/nvim-treesitter",
        config = function()
            require 'nvim-treesitter.configs'.setup {
                ensure_installed = { "c", "lua", "python", "rust", "php", "typescript", "css", "javascript", "html" },
                highlight = {
                    enable = true,
                }
            }
        end
    },
    {
        "nvim-tree/nvim-tree.lua",
        lazy = false,
        priority = 1,
        dependencies = {
            "nvim-tree/nvim-web-devicons", -- optional, for file icons
        },
        config = function()
            require("config/tree-conf")
        end,
    },
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "mfussenegger/nvim-dap-python",
        },
        config = function()
            require("config/dap")
        end,
    },
    { "rcarriga/nvim-dap-ui",      dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" }, config = get_config("dap-ui") },
    { "jparise/vim-graphql" },
    { "hoob3rt/lualine.nvim" },
    { "windwp/nvim-ts-autotag",    config = get_config("ts-autotag") },
    { "akinsho/git-conflict.nvim", config = get_config("git-conflict") },
    {
        "lewis6991/gitsigns.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        config = function()
            require("config/gitsigns")
        end,
    },
    {
        "FeiyouG/command_center.nvim",
        dependencies = {
            "nvim-telescope/telescope.nvim",
        },
        config = function()
            require("config/palette")
        end,
    },
    {
        "sindrets/diffview.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        config = function()
            --            require("config/diffview")
        end,
    },
    {
        "mrcjkb/rustaceanvim",
        version = '^4', -- Recommended
        ft = { 'rust' },
    },
    {
        "yioneko/nvim-vtsls",
        config = function()
            require('vtsls').config({
                -- customize handlers for commands
                handlers = {
                    source_definition = function(err, locations)
                    end,
                    file_references = function(err, locations)
                    end,
                    code_action = function(err, actions)
                    end,
                },
                -- automatically trigger renaming of extracted symbol
                refactor_auto_rename = true,
            })
        end
    },
    {
        "nvim-telescope/telescope-ui-select.nvim",
        config = function()
            require("config/select-ui")
        end
    }
})
