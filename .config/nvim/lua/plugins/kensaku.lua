return {
  {
    'lambdalisue/kensaku.vim',
    dependencies = {
      'vim-denops/denops.vim',
    },
    event = 'VeryLazy',
  },
  {
    'lambdalisue/kensaku-search.vim',
    dependencies = {
      'lambdalisue/kensaku.vim',
    },
    event = 'VeryLazy',
  },
}
