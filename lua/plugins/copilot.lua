return {
    -- this plugin is for copilot
    "zbirenbaum/copilot.lua",

    -- config copilot
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
}
