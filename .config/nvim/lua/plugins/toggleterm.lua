return {
  'akinsho/toggleterm.nvim',
  event = 'VeryLazy',
  keys = {
    {
      '<leader>g',
      function()
        require('toggleterm.terminal').Terminal:new({ cmd = 'lazygit', hidden = true, direction = 'float' }):toggle()
      end,
    },
  },
  config = function()
    require('toggleterm').setup()
  end,
}
