local lazygit

return {
  'akinsho/toggleterm.nvim',
  lazy = true,
  keys = {
    {
      '<leader>g',
      function()
        lazygit:toggle()
      end,
    },
  },
  config = function()
    require('toggleterm').setup()
    local terminal = require('toggleterm.terminal').Terminal
    lazygit = terminal:new({
      cmd = 'lazygit',
      dir = 'git_dir',
      hidden = true,
      direction = 'float',
    })
  end,
}
