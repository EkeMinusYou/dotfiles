local lazygit

return {
  'akinsho/toggleterm.nvim',
  event = 'VeryLazy',
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
    local terminal = require('toggleterm.terminal')
    lazygit = terminal.Terminal:new({
      cmd = 'lazygit',
      hidden = true,
      direction = 'float',
    })
  end,
}
