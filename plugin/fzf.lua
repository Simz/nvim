vim.pack.add({ 'https://github.com/ibhagwan/fzf-lua' })
local fzf = require("fzf-lua")
fzf.setup({
    winopts = {
        preview = {
            delay = 0,       -- Remove delay for instantaneous previews
        },
    },
})
fzf.setup({'fzf-native'})
fzf.register_ui_select({ silent = true })
