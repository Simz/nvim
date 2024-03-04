require 'nvim-treesitter.configs'.setup {
  autotag = {
    enable = true,
    filetypes = { "html", "xml", "php", "vue" },
  }
}
require('nvim-ts-autotag').setup()
