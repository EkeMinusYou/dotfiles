return {
  'sindrets/diffview.nvim',
  lazy = true,
  keys = {
    { '<leader>d', '<cmd>DiffviewOpen<cr>', mode = { 'n', 'v' } },
    { '<leader>h', '<cmd>DiffviewFileHistory<cr>', mode = { 'n', 'v' } },
    { '<leader>D', '<cmd>DiffviewClose<cr>', mode = { 'n', 'v' } },
  },
  cmd = {
    'DiffviewOpen',
  },
  config = function()
    require('diffview').setup({})
  end,
}
