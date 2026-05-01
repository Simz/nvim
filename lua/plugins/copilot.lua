return {
    -- this plugin is for copilot
    "zbirenbaum/copilot.lua",

    dependencies = {
        "copilotlsp-nvim/copilot-lsp",
    },

    -- for all fyletypes
    filetypes = {
        "*",
    },
    -- config copilot
    config = function()
        require("copilot").setup({
            filetypes = {
            },
            nes = {
                enabled = true,
                keymap = {
                    accept_and_goto = "<Tab>",
                    accept = false,
                    dismiss = "<Esc>",
                },
            },
            suggestion = {
                enabled = true,
                auto_trigger = true,
                keymap = {
                    accept = "<C-y>",
                }
            },
        })
    end,
}
