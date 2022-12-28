require 'nvim-treesitter.configs'.setup {
  ensure_installed = 'all',
  auto_install = true,

  highlight = {
    enable = true,
  },

  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = nil,
  },
}
