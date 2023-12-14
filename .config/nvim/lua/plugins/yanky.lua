return {
  'gbprod/yanky.nvim',
  keys = {
    { 'p', '<Plug>(YankyPutAfter)', mode = { 'n', 'x' } },
    { 'P', '<Plug>(YankyPutBefore)', mode = { 'n', 'x' } },
    { '<c-n>', '<Plug>(YankyCycleForward)', mode = { 'n', 'x' } },
    { '<c-p>', '<Plug>(YankyCycleBackward)', mode = { 'n', 'x' } },
  },
  event = { 'VeryLazy' },
  config = function()
    require('yanky').setup()
  end,
}
