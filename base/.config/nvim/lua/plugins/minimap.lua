return {
  'Isrothy/neominimap.nvim',
  version = 'v3.*.*',
  event = 'BufRead',
  keys = {
    { '<leader>ll', '<cmd>Neominimap Toggle<cr>', desc = 'Toggle minimap' },
  },
  init = function()
    vim.opt.wrap = false
    vim.opt.sidescrolloff = 20
    ---@type Neominimap.UserConfig
    vim.g.neominimap = {
      auto_enable = true,
      layout = 'split',
    }
  end,
}
