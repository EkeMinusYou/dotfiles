return {
  'echasnovski/mini.nvim',
  event = 'BufReadPost',
  config = function()
    require('mini.comment').setup({})
  end,
}
