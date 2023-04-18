local M = {}
function M.docker_logs() 
    local current_dir = vim.fn.substitute(vim.fn['getcwd'](), '^.*/', '', '')
    --vim.api.nvim_command("call floaterm#run('new',1,[],'docker ps')")
    local cmd = {}
    cmd = 'ls -lah'
    vim.api.nvim_command('FloatermToggle!' .. cmd)
  --  vim.api.nvim_call_function("floaterm#new",{true, cmd, fnarg, fnarg})
end
return M
