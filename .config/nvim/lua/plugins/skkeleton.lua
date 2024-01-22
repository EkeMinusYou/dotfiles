return {
  'vim-skk/skkeleton',
  event = 'VeryLazy',
  keys = {
    { '<c-j>', '<Plug>(skkeleton-enable)', mode = { 'i', 'c' } },
  },
  dependencies = {
    'vim-denops/denops.vim',
  },
}
