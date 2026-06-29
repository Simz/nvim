-- 1. Download and source the plugin via built-in packages
vim.pack.add({
  { src = "https://github.com/carlos-algms/agentic.nvim" }
})

-- 2. Configure and initialize agentic.nvim with Gemini
require("agentic").setup({
  provider = "gemini-acp", -- Instructs the plugin to use gemini-acp
  position = "right",      -- "right", "left", or "bottom"
  width = 40,              -- Sidebar width
})

-- 3. Corrected custom keymaps using the Lua API
vim.keymap.set("n", "<leader>aa", function()
  require("agentic").toggle()
end, { desc = "Toggle Gemini AI Chat" })

vim.keymap.set("v", "<leader>av", function()
  require("agentic").add_selection()
end, { desc = "Send selection to Gemini" })
