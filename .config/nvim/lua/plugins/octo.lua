return {
  'pwntester/octo.nvim',
  event = 'VeryLazy',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
    'nvim-tree/nvim-web-devicons',
  },
  keys = {
    { 'gh', '<CMD>Octo actions<CR>' },
  },
  config = function()
    require('octo').setup()
  end,
}
