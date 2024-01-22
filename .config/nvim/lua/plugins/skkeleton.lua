return {
  {
    'vim-skk/skkeleton',
    event = 'VeryLazy',
    keys = {
      { '<c-j>', '<Plug>(skkeleton-enable)', mode = { 'i', 'c' } },
    },
    dependencies = {
      'vim-denops/denops.vim',
      'skk-dev/dict',
    },
    config = function()
      local dict = vim.fn.stdpath('data') .. '/lazy/dict'
      vim.fn['skkeleton#config']({
        globalDictionaries = {
          dict .. '/SKK-JISYO.L',
          dict .. '/SKK-JISYO.jinmei',
          dict .. '/SKK-JISYO.geo',
          dict .. '/SKK-JISYO.station',
          dict .. '/SKK-JISYO.propernoun',
        },
      })
    end,
  },
}
