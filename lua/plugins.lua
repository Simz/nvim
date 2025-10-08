function get_config(name)
    return string.format('require("config/%s")', name)
end

return require("lazy").setup({
    defaults = {
        lazy = false,
    },
    {
        "ibhagwan/fzf-lua",
        -- optional for icon support
        dependencies = { "nvim-tree/nvim-web-devicons" },
        -- or if using mini.icons/mini.nvim
        -- dependencies = { "echasnovski/mini.icons" },
        opts = {}
    },
    {
        'kristijanhusak/vim-dadbod-ui',
        dependencies = {
            { 'tpope/vim-dadbod',                     lazy = true },
            { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true }, -- Optional
        },
        cmd = {
            'DBUI',
            'DBUIToggle',
            'DBUIAddConnection',
            'DBUIFindBuffer',
        },
        init = function()
            -- Your DBUI configuration
            vim.g.db_ui_use_nerd_fonts = 1
        end,
    },
    {
        'MeanderingProgrammer/render-markdown.nvim',
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
        -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
        -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
        ---@module 'render-markdown'
        ---@type render.md.UserConfig
        opts = {},
    },
    {
        "olimorris/codecompanion.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        opts = {
            strategies = {
                --NOTE: Change the adapter as required
                chat = { adapter = "gemini" },
                inline = { adapter = "gemini" },
            },
        },
    },
    {
        "folke/sidekick.nvim",
        opts = {
            -- add any options here
            cli = {
                mux = {
                    backend = "zellij",
                    enabled = false,
                },
            },
        },
        -- stylua: ignore
        keys = {
            {
                "<tab>",
                function()
                    -- if there is a next edit, jump to it, otherwise apply it if any
                    if not require("sidekick").nes_jump_or_apply() then
                        return "<Tab>" -- fallback to normal tab
                    end
                end,
                expr = true,
                desc = "Goto/Apply Next Edit Suggestion",
            },
            {
                "<leader>aa",
                function() require("sidekick.cli").toggle() end,
                desc = "Sidekick Toggle CLI",
            },
            {
                "<leader>as",
                function() require("sidekick.cli").select() end,
                -- Or to select only installed tools:
                -- require("sidekick.cli").select({ filter = { installed = true } })
                desc = "Select CLI",
            },
            {
                "<leader>at",
                function() require("sidekick.cli").send({ msg = "{this}" }) end,
                mode = { "x", "n" },
                desc = "Send This",
            },
            {
                "<leader>av",
                function() require("sidekick.cli").send({ msg = "{selection}" }) end,
                mode = { "x" },
                desc = "Send Visual Selection",
            },
            {
                "<leader>ap",
                function() require("sidekick.cli").prompt() end,
                mode = { "n", "x" },
                desc = "Sidekick Select Prompt",
            },
            {
                "<c-.>",
                function() require("sidekick.cli").focus() end,
                mode = { "n", "x", "i", "t" },
                desc = "Sidekick Switch Focus",
            },
            -- Example of a keybinding to open Claude directly
            {
                "<leader>ac",
                function() require("sidekick.cli").toggle({ name = "claude", focus = true }) end,
                desc = "Sidekick Toggle Claude",
            },
        },
    },
    {
        "copilotlsp-nvim/copilot-lsp",
        init = function()
            vim.g.copilot_nes_debounce = 500
            vim.lsp.enable("copilot_ls")
            vim.keymap.set("n", "<Tab>", function()
                local bufnr = vim.api.nvim_get_current_buf()
                local state = vim.b[bufnr].nes_state
                if state then
                    -- Try to jump to the start of the suggestion edit.
                    -- If already at the start, then apply the pending suggestion and jump to the end of the edit.
                    local _ = require("copilot-lsp.nes").walk_cursor_start_edit()
                        or (
                            require("copilot-lsp.nes").apply_pending_nes()
                            and require("copilot-lsp.nes").walk_cursor_end_edit()
                        )
                    return nil
                else
                    -- Resolving the terminal's inability to distinguish between `TAB` and `<C-i>` in normal mode
                    return "<C-i>"
                end
            end, { desc = "Accept Copilot NES suggestion", expr = true })
        end,
    },
    {
        "zbirenbaum/copilot.lua",
        config = function()
            require("copilot").setup({
                filetypes = {
                    ["*"] = true
                },
                suggestion = {
                    auto_trigger = true,

                    keymap = {
                        accept = "<C-y>",
                    }
                },
            })
        end,
    },
    --{
    --    "CopilotC-Nvim/CopilotChat.nvim",
    --    branch = "main",
    --    dependencies = {
    --        { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
    --        { "nvim-lua/plenary.nvim" },  -- for curl, log wrapper
    --    },
    --    build = "make tiktoken",          -- Only on MacOS or Linux
    --    opts = {
    --        debug = true,                 -- Enable debugging
    --        -- See Configuration section for rest
    --    },
    --    -- See Commands section for default commands if you want to lazy load on them
    --},
    --{
    --    "yetone/avante.nvim",
    --    event = "VeryLazy",
    --    version = false, -- Never set this value to "*"! Never!
    --    ---@module 'avante'
    --    ---@type avante.Config
    --    opts = {
    --        -- add any opts here
    --        -- for example
    --        provider = "copilot",
    --        providers = {
    --            openai = {
    --                endpoint = "https://api.openai.com/v1",
    --                model = "gpt-4o",                 -- your desired model (or use gpt-4o, etc.)
    --                extra_request_body = {
    --                    timeout = 30000,              -- Timeout in milliseconds, increase this for reasoning models
    --                    temperature = 0.75,
    --                    max_completion_tokens = 8192, -- Increase this to include reasoning tokens (for reasoning models)
    --                    --reasoning_effort = "medium", -- low|medium|high, only used for reasoning models
    --                },
    --            },
    --        },
    --    },
    --    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    --    build = "make",
    --    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    --    dependencies = {
    --        "nvim-treesitter/nvim-treesitter",
    --        "nvim-lua/plenary.nvim",
    --        "MunifTanjim/nui.nvim",
    --        --- The below dependencies are optional,
    --        "echasnovski/mini.pick",         -- for file_selector provider mini.pick
    --        "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
    --        "hrsh7th/nvim-cmp",              -- autocompletion for avante commands and mentions
    --        "ibhagwan/fzf-lua",              -- for file_selector provider fzf
    --        "stevearc/dressing.nvim",        -- for input provider dressing
    --        "folke/snacks.nvim",             -- for input provider snacks
    --        "nvim-tree/nvim-web-devicons",   -- or echasnovski/mini.icons
    --        "zbirenbaum/copilot.lua",        -- for providers='copilot'
    --        {
    --            -- support for image pasting
    --            "HakonHarnes/img-clip.nvim",
    --            event = "VeryLazy",
    --            opts = {
    --                -- recommended settings
    --                default = {
    --                    embed_image_as_base64 = false,
    --                    prompt_for_file_name = false,
    --                    drag_and_drop = {
    --                        insert_mode = true,
    --                    },
    --                    -- required for Windows users
    --                    use_absolute_path = true,
    --                },
    --            },
    --        },
    --        {
    --            -- Make sure to set this up properly if you have lazy=true
    --            'MeanderingProgrammer/render-markdown.nvim',
    --            opts = {
    --                file_types = { "markdown", "Avante" },
    --            },
    --            ft = { "markdown", "Avante" },
    --        },
    --    },
    --},
    {
        "olimorris/onedarkpro.nvim",
        lazy = false,
        config = function()
            require("config/onedark")
            vim.cmd([[colorscheme onedark]])
        end,
    },
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
        'saghen/blink.cmp',
        -- optional: provides snippets for the snippet source
        dependencies = { 'rafamadriz/friendly-snippets' },

        -- use a release tag to download pre-built binaries
        version = '1.*',
        -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
        -- build = 'cargo build --release',
        -- If you use nix, you can build from source using latest nightly rust with:
        -- build = 'nix run .#build-plugin',

        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
            -- 'super-tab' for mappings similar to vscode (tab to accept)
            -- 'enter' for enter to accept
            -- 'none' for no mappings
            --
            -- All presets have the following mappings:
            -- C-space: Open menu or open docs if already open
            -- C-n/C-p or Up/Down: Select next/previous item
            -- C-e: Hide menu
            -- C-k: Toggle signature help (if signature.enabled = true)
            --

            keymap = { preset = 'enter' },

            appearance = {
                -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
                -- Adjusts spacing to ensure icons are aligned
                nerd_font_variant = 'mono'
            },

            -- (Default) Only show the documentation popup when manually triggered
            completion = { documentation = { auto_show = false } },

            -- Default list of enabled providers defined so that you can extend it
            -- elsewhere in your config, without redefining it, due to `opts_extend`
            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer' },
            },

            -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
            -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
            -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
            --
            -- See the fuzzy documentation for more information
            fuzzy = { implementation = "prefer_rust_with_warning" }
        },
        opts_extend = { "sources.default" }
    },
    --{
    --    "L3MON4D3/LuaSnip",
    --    config = function()
    --        require("config/luasnip")
    --    end,
    --},
    --{
    --    "hrsh7th/nvim-cmp",
    --    dependencies = {
    --        "hrsh7th/cmp-buffer",
    --        "hrsh7th/cmp-path",
    --        "hrsh7th/cmp-nvim-lsp",
    --        "hrsh7th/cmp-nvim-lua",
    --        "hrsh7th/cmp-calc",
    --        "hrsh7th/cmp-nvim-lsp-signature-help",
    --    },
    --    config = function()
    --        require('config/completion')
    --    end,
    --},
    --{ "saadparwaiz1/cmp_luasnip" },
    --{
    --    "nvim-telescope/telescope.nvim",
    --    dependencies = {
    --        "nvim-lua/popup.nvim",
    --        "nvim-lua/plenary.nvim"
    --    },
    --},
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
            "nvim-dap-python"
        },
        config = function()
            require("config/dap")
        end,
    },
    { "rcarriga/nvim-dap-ui",      dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" }, config = get_config("dap-ui") },
    { "jparise/vim-graphql" },
    { "hoob3rt/lualine.nvim" },
    { "windwp/nvim-ts-autotag",    config = get_config("ts-autotag") },
    { "akinsho/git-conflict.nvim", config = get_config("git-conflict"),                                 tag = 'v2.1.0' },
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
    --    {
    --        "mrcjkb/rustaceanvim",
    --        version = '^4', -- Recommended
    --        ft = { 'rust' },
    --    },
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
