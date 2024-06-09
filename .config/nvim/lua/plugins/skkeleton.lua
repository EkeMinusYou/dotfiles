return {
  {
    'vim-skk/skkeleton',
    event = 'VeryLazy',
    keys = {
      { '<c-j>', '<Plug>(skkeleton-enable)', mode = { 'i', 'c' } },
    },
    dependencies = {
      'vim-denops/denops.vim',
    },
    config = function()
      local dict = os.getenv('HOME') .. '/src/github.com/skk-dev/dict'
      local config = vim.fn['skkeleton#config']
      config({
        globalDictionaries = {
          dict .. '/SKK-JISYO.L',
          dict .. '/SKK-JISYO.jinmei',
          dict .. '/SKK-JISYO.geo',
          dict .. '/SKK-JISYO.station',
          dict .. '/SKK-JISYO.propernoun',
        },
        userDictionary = '~/.skk/skk-jisyo.utf8',
      })
      local register_kanatable = vim.fn['skkeleton#register_kanatable']
      register_kanatable('rom', require('skkeleton.azik'))
    end,
  },
}
