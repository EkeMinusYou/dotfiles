return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
  },
  -- keys = {
  --   {
  --     '<leader>gg',
  --     function()
  --       Snacks.lazygit()
  --     end,
  --     desc = 'Lazygit',
  --   },
  -- },
}