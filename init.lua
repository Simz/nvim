vim.g.mapleader = ","
vim.g.maplocalleader = ","

vim.opt.termsync = false
vim.o.winborder = "rounded"

vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.expandtab = true
vim.opt.tabstop = 4      -- A tab counts for 4 spaces
vim.opt.shiftwidth = 4   -- Size of an indent
vim.opt.softtabstop = 4

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.undofile = true

-- keep signcolumn on by default
vim.opt.signcolumn = "yes"
vim.opt.cursorline = true

-- split right 
vim.opt.splitright = true

-- set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = tree

vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.INFO] = " ",
      [vim.diagnostic.severity.HINT] = " ",
    },
  },
  virtual_text = true, -- show inline diagnostics
})

vim.cmd.colorscheme("catppuccin")
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], {noremap = true})

vim.api.nvim_create_user_command("Format", function(args)
  local range = nil
  if args.count ~= -1 then
    local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
    range = {
      start = { args.line1, 0 },
      ["end"] = { args.line2, end_line:len() },
    }
  end
  require("conform").format({ async = true, lsp_format = "fallback", range = range })
end, { range = true })


vim.g.clipboard = {
  name = 'OSC 52',
  copy = {
    ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
    ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
  },
  paste = {
    ['+'] = function () end,
    ['*'] = function () end,
  },
}

-- Define your commands here
local my_commands = {
  { label = "Cache flush", cmd = "!t3 cache:flush", notify = true },
  { label = "tmdt up", cmd = "!tmdt up ." },
  { label = "Database update schema", cmd = "!t3 database:updateschema", notify = true },
}

local function run_shell_select()
  vim.ui.select(my_commands, {
    prompt = 'Select Shell Command:',
    format_item = function(item)
      return item.label
    end,
  }, function(choice)
    if choice then
        -- 1. Strip the '!' and any 'split | term' prefix from your table
      -- We want just the raw command: "t3 cache:flush"
      local pure_cmd = choice.cmd:gsub("^!", ""):gsub("split | term ", "")

      -- 2. Open a floating window
      local width, height, row, col
      if choice.notify then
        -- Small notification-style float, top right
        width = math.floor(vim.o.columns * 0.3)
        height = 6
        row = 1
        col = vim.o.columns - width - 1
      else
        width = math.floor(vim.o.columns * 0.8)
        height = math.floor(vim.o.lines * 0.8)
        row = math.floor((vim.o.lines - height) / 2)
        col = math.floor((vim.o.columns - width) / 2)
      end

      local buf = vim.api.nvim_create_buf(false, true)
      vim.api.nvim_open_win(buf, true, {
        relative = "editor",
        width = width,
        height = height,
        row = row,
        col = col,
        style = "minimal",
        border = "rounded",
      })

      -- 3. Run the command via interactive zsh in the floating buffer
      vim.fn.termopen(string.format("zsh -ic '%s'", pure_cmd))

      -- 4. Enter insert mode automatically
      vim.cmd("startinsert")
    else
      print("Selection cancelled")
    end
  end)
end

-- Map <leader>r to the function
vim.keymap.set('n', '<leader>r', run_shell_select, { desc = 'Run shell command from menu' })

