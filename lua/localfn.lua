local M = {}
function M.toggleterm() 
    local cmd = {}
    cmd = 'ls -lah'
    vim.api.nvim_command('FloatermToggle!' .. cmd)
  --  vim.api.nvim_call_function("floaterm#new",{true, cmd, fnarg, fnarg})
end
return M
