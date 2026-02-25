return {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
    config = function(_, opts)
        local fzf = require("fzf-lua")

        -- 1. Initialize the plugin
        fzf.setup(opts)

        -- 2. Force register with 'silent' to kill the warning
        -- This is the Lua version of ':FzfLua register_ui_select'
        fzf.register_ui_select({ silent = true })
    end,
}
