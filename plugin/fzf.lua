vim.pack.add({ 'https://github.com/ibhagwan/fzf-lua' })
local fzf = require("fzf-lua")
fzf.setup({
--    grep = {
--        cmd = "rg --vimgrep --hidden --follow",
--    },
    winopts = {
        preview = {
--            default = 'bat', -- Use bat for fast syntax highlighting
            delay = 0,       -- Remove delay for instantaneous previews
        },
    },
})
fzf.register_ui_select({ silent = true })
