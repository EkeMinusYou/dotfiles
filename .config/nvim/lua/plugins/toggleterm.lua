return {
  'akinsho/toggleterm.nvim',
  event = 'VeryLazy',
  keys = {
    { '<leader>t', '<cmd>ToggleTerm direction=horizontal size=15<cr>' },
    { '<c-q>', '<cmd>ToggleTerm direction=horizontal size=15<cr>', mode = 't' },
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
