return {
  'phaazon/hop.nvim',
  version = 'v2.x',
  event = 'BufReadPost',
  keys = {
    { '<leader><leader>', '<cmd>HopWord<CR>' },
  },
  config = function()
    require('hop').setup({ keys = 'etovxqpdygfblzhckisuran' })
  end,
}
