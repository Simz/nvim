vim.pack.add({ 'https://github.com/ibhagwan/fzf-lua' })
local fzf = require("fzf-lua")
fzf.setup({})
fzf.register_ui_select({ silent = true })
