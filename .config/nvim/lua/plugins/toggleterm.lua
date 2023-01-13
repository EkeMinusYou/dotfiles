return {
  'akinsho/toggleterm.nvim',
  event = 'VeryLazy',
  keys = {
    { '<leader>t', '<CMD>ToggleTerm direction=vertical size=80<CR>'},
    { '<c-q>', '<CMD>ToggleTerm direction=vertical size=80<CR>', mode = 't' },
    {
      '<leader>g',
      "<CMD>lua require('toggleterm.terminal').Terminal:new({cmd = 'lazygit', hidden = true, direction = 'float'}):toggle()<CR>",
    },
  },
  config = function()
    require('toggleterm').setup()
  end,
}
