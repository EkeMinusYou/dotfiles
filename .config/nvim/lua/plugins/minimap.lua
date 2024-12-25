return {
  'Isrothy/neominimap.nvim',
  version = 'v3.*.*',
  event = 'BufRead',
  init = function()
    vim.opt.wrap = false
    vim.opt.sidescrolloff = 20
    ---@type Neominimap.UserConfig
    vim.g.neominimap = {
      auto_enable = true,
    }
  end,
}
