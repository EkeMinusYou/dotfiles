return {
  {
    'lambdalisue/kensaku.vim',
    dependencies = {
      'vim-denops/denops.vim',
    },
    lazy = true,
  },
  {
    'lambdalisue/kensaku-search.vim',
    dependencies = {
      'lambdalisue/kensaku.vim',
    },
    event = 'VeryLazy',
  },
}
