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
    'echasnovski/mini.comment',
    event = 'BufReadPost',
    config = function()
      require('mini.comment').setup({})
    end,
  },
  {
    'echasnovski/mini.splitjoin',
    event = 'BufReadPost',
    config = function()
      require('mini.splitjoin').setup({
        mappings = {
          toggle = '<leader>m',
          split = '',
          join = '',
        },
      })
    end,
  },
}
