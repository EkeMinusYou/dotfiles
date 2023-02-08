return {
  'phaazon/hop.nvim',
  version = 'v2.x',
  event = 'BufReadPost',
  keys = {
    { '<leader><leader>', '<cmd>HopWord<cr>', mode = { 'n', 'v' } },
  },
  config = function()
    require('hop').setup({ keys = 'etovxqpdygfblzhckisuran' })
  end,
}
