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
  {
    'echasnovski/mini.files',
    keys = {
      { '<leader>e', ':lua MiniFiles.open()<cr>' },
    },
    event = 'VeryLazy',
    config = function()
      require('mini.files').setup({
        options = {
          permanent_delete = false,
        },

        windows = {
          preview = true,
          width_focus = 20,
          width_nofocus = 20,
          width_preview = 100,
        },
      })
    end,
  },
}
