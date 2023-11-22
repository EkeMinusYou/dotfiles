return {
  'sindrets/diffview.nvim',
  event = 'VeryLazy',
  keys = {
    { '<leader>d', '<cmd>DiffviewOpen<cr>', mode = { 'n', 'v' } },
    { '<leader>h', '<cmd>DiffviewFileHistory<cr>', mode = { 'n', 'v' } },
    { '<leader>D', '<cmd>DiffviewClose<cr>', mode = { 'n', 'v' } },
  },
  config = function()
    require('diffview').setup({})
  end,
}
