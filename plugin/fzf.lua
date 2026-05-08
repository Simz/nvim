vim.pack.add({ 'https://github.com/ibhagwan/fzf-lua' })
local fzf = require("fzf-lua")
fzf.setup({'fzf-native'})
fzf.register_ui_select({ silent = true })
