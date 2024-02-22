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
    'echasnovski/mini.animate',
    event = 'VeryLazy',
    config = function()
      local animate = require('mini.animate')
      animate.setup({
        scroll = {
          timing = animate.gen_timing.linear({ duration = 100, unit = 'total' }),
        },
        cursor = {
          timing = animate.gen_timing.linear({ duration = 100, unit = 'total' }),
        },
        resize = {
          timing = animate.gen_timing.linear({ duration = 100, unit = 'total' }),
        },
        open = {
          timing = animate.gen_timing.linear({ duration = 100, unit = 'total' }),
        },
        close = {
          timing = animate.gen_timing.linear({ duration = 100, unit = 'total' }),
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
