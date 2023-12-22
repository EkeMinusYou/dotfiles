return {
  'echasnovski/mini.cursorword',
  event = 'BufReadPost',
  config = function()
    require('mini.cursorword').setup({})
  end,
}
