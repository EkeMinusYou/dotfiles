return {
  'yuki-yano/fuzzy-motion.vim',
  dependencies = {
    'vim-denops/denops.vim',
  },
  lazy = true,
  keys = {
    { '<leader><leader>', '<cmd>FuzzyMotion<cr>', mode = { 'n', 'v' } },
  },
  config = function()
    vim.cmd("let g:fuzzy_motion_matchers = ['kensaku', 'fzf']")
  end,
}
