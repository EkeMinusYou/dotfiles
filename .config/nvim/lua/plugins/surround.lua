return {
  'echasnovski/mini.surround',
  version = '*',
  event = 'BufReadPost',
  config = function()
    require('mini.surround').setup({})
  end,
}
