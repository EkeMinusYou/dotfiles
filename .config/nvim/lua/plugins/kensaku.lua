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
  {
    'yuki-yano/fuzzy-motion.vim',
    dependencies = {
      'vim-denops/denops.vim',
      'lambdalisue/kensaku.vim',
    },
    config = function()
      vim.keymap.set('n', '<leader><leader>', '<cmd>FuzzyMotion<cr>', { noremap = true, silent = true })
      vim.cmd("let g:fuzzy_motion_matchers = ['kensaku', 'fzf']")
    end,
  },
}
