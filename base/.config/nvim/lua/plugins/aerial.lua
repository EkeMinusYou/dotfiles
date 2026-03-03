return {
  'stevearc/aerial.nvim',
  event = 'LspAttach',
  keys = {
    { '<leader>o', '<cmd>AerialToggle!<cr>' },
  },
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    require('aerial').setup()
  end,
}
