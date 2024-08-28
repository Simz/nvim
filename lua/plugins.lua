function get_config(name)
    return string.format('require("config/%s")', name)
end

return require("lazy").setup({
    defaults = {
        lazy = true,
    },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    dependencies = {
      { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
      { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
    },
    opts = {
      debug = true, -- Enable debugging
      -- See Configuration section for rest
    },
    -- See Commands section for default commands if you want to lazy load on them
  },
    {
        "olimorris/onedarkpro.nvim",
        lazy = false,
        config = function()
            get_config("onedark")
            vim.cmd([[colorscheme onedark]])
        end,
    },
    {
        "nvimtools/none-ls.nvim", config = function()
            require("config/nullls")
        end,
    },
    {
        "github/copilot.vim", config = function()
        end,
    },
    { 
        "L3MON4D3/LuaSnip", config = function() 
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

    { "williamboman/mason.nvim", config = function() 
            require("config/mason") 
        end,
    },
    { "williamboman/mason-lspconfig.nvim" },
    { "neovim/nvim-lspconfig" },
    { "nvim-treesitter/nvim-treesitter", config = function()
        require 'nvim-treesitter.configs'.setup {
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
        "simrat39/rust-tools.nvim"
    },
    {
        "yioneko/nvim-vtsls",
        config = function()
            require('vtsls').config({
                -- customize handlers for commands
                handlers = {
                    source_definition = function(err, locations) end,
                    file_references = function(err, locations) end,
                    code_action = function(err, actions) end,
                },
                -- automatically trigger renaming of extracted symbol
                refactor_auto_rename = true,
            })
        end
    },
    {
        "nvim-telescope/telescope-ui-select.nvim",
        keys = {
            { "<leader>c", "<cmd>lua vim.lsp.buf.code_action()<CR>" },
        },
        config = function()
            require("config/select-ui")
        end
    }



})
