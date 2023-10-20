function get_config(name)
    return string.format('require("config/%s")', name)
end

return require("lazy").setup({
    {
        "olimorris/onedarkpro.nvim",
        lazy = false,
        config = function()
            get_config("onedark")
            vim.cmd([[colorscheme onedark]])
        end,
    },
    {
        "jose-elias-alvarez/null-ls.nvim", config = function()
            require("config/nullls")
        end,
    },

    { "L3MON4D3/LuaSnip", config = require("config/luasnip") },

    { "voldikss/vim-floaterm" },

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
    { "ggandor/lightspeed.nvim" },
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/popup.nvim",
            "nvim-lua/plenary.nvim"
        },
    },
    { "williamboman/mason.nvim", config = require("config/mason") },
    { "williamboman/mason-lspconfig.nvim" },
    { "neovim/nvim-lspconfig" },
    { "nvim-treesitter/nvim-treesitter" },

    {
        "nvim-tree/nvim-tree.lua",
        lazy = false,
        priority = 1,
        dependencies = {
            "nvim-tree/nvim-web-devicons", -- optional, for file icons
        },
        keys = {
            { "<leader>q", "<cmd>NvimTreeToggle<CR>", desc = "NeoTree" },
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
    { "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap" }, config = get_config("dap-ui") },
    { "jparise/vim-graphql" },
    { "hoob3rt/lualine.nvim" },
    { "windwp/nvim-ts-autotag", config = get_config("ts-autotag") },
--    { "mhartington/formatter.nvim", config = get_config("formatter") },
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
    { 'jose-elias-alvarez/null-ls.nvim' },
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
        "ggandor/leap.nvim",
        config = function()
            require('leap').add_default_mappings()
        end,
    },
    {
        "simrat39/rust-tools.nvim"
    }



})
