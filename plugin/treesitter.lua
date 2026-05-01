vim.pack.add({ 'https://github.com/nvim-treesitter/nvim-treesitter' })
pcall(function()
    require 'nvim-treesitter.configs'.setup {
        ensure_installed = { "c", "lua", "python", "rust", "php", "typescript", "css", "javascript", "html" },
        highlight = { enable = true }
    }
end)
vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    if ev.data.spec.name == 'nvim-treesitter' and ev.data.kind == 'update' then
      vim.cmd('TSUpdate')
    end
  end
})
