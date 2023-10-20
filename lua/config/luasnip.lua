--require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_vscode").lazy_load({ paths = "~/.config/nvim/vscodeSnippets" })
require("luasnip.loaders.from_snipmate").lazy_load()
-- If path is not specified, luasnip will look for the `snippets` directory in rtp (for custom-snippet probably
-- `~/.config/nvim/snippets`).
