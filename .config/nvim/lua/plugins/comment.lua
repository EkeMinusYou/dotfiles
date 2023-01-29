return {
  'echasnovski/mini.comment',
  event = 'BufReadPost',
  config = function()
    require('mini.comment').setup({})
  end,
}
