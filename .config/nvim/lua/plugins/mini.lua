return {
  {
    'echasnovski/mini.surround',
    event = { 'BufReadPost', 'BufWritePost', 'BufNewFile' },
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
    'echasnovski/mini.splitjoin',
    event = { 'LspAttach' },
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
