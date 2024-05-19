return {
  'gbprod/yanky.nvim',
  keys = {
    { 'y', '<Plug>(YankyYank)', mode = { 'n', 'x' } },
    { 'p', '<Plug>(YankyPutAfter)', mode = { 'n', 'x' } },
    { 'P', '<Plug>(YankyPutBefore)', mode = { 'n', 'x' } },
    { '<c-n>', '<Plug>(YankyCycleForward)', mode = { 'n', 'x' } },
    { '<c-p>', '<Plug>(YankyCycleBackward)', mode = { 'n', 'x' } },
  },
  lazy = true,
  config = function()
    require('yanky').setup({
      ring = {
        storage = 'memory',
      },
    })
  end,
}
