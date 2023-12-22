return {
  {
    'echasnovski/mini.surround',
    event = 'VeryLazy',
    config = function()
      require('mini.surround').setup({
        mappings = {
          add = 'ys',
          delete = 'ds',
          find = '',
          find_left = '',
          highlight = '',
          replace = 'cs',
          update_n_lines = '',

          suffix_last = '',
          suffix_next = '',
        },
      })
    end,
  },
  {
    'echasnovski/mini.cursorword',
    event = 'BufReadPost',
    config = function()
      require('mini.cursorword').setup({})
    end,
  },
  {
    'echasnovski/mini.animate',
    event = 'VeryLazy',
    config = function()
      require('mini.animate').setup({
        scroll = {
          enable = false,
        },
      })
    end,
  },
  {
    'echasnovski/mini.comment',
    event = 'BufReadPost',
    config = function()
      require('mini.comment').setup({})
    end,
  },
}
