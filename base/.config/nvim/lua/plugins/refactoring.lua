return {
  'ThePrimeagen/refactoring.nvim',
  lazy = false,
  dependencies = {
    'lewis6991/async.nvim',
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  config = function()
    require('refactoring').setup()
  end,
}
