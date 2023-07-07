return {
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
        replace = 'rs',
        update_n_lines = '',

        suffix_last = '',
        suffix_next = '',
      },
    })
  end,
}
