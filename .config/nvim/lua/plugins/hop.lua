return {
  'phaazon/hop.nvim',
  version = 'v2.x',
  event = 'BufReadPost',
  keys = {
    { '<leader>hw', '<cmd>HopWord<CR>' },
    { '<leader>hl', '<cmd>HopLine<CR>' },
    { '<leader>hc', '<cmd>HopChar1<CR>' },
  },
  config = function()
    require('hop').setup({ keys = 'etovxqpdygfblzhckisuran' })
  end,
}
