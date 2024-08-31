return {
  'joshuadanpeterson/typewriter',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
  },
  event = 'BufReadPost',
  config = function()
    require('typewriter').setup()
  end,
}
