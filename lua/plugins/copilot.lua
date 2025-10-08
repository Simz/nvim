
return {
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
}
