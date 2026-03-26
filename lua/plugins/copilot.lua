return {
    -- this plugin is for copilot
    "zbirenbaum/copilot.lua",
    dependencies = {
        "copilotlsp-nvim/copilot-lsp",
    },

    -- config copilot
    config = function()
        vim.lsp.enable("copilot_ls")
        require("copilot").setup({
            filetypes = {
                ["*"] = true
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
                auto_trigger = true,

                keymap = {
                    accept = "<C-y>",
                }
            },
        })
    end,
}
