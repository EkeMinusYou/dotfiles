return {
  'akinsho/toggleterm.nvim',
  event = 'VeryLazy',
  keys = {
    { '<leader>t', '<CMD>ToggleTerm direction=float<CR>' },
    { '<c-q>', '<CMD>ToggleTerm direction=float<CR>', mode = 't' },
    {
      '<leader>g',
      "<CMD>lua require('toggleterm.terminal').Terminal:new({cmd = 'lazygit', hidden = true, direction = 'float'}):toggle()<CR>",
    },
    {
      '<leader>k',
      "<CMD>lua require('toggleterm.terminal').Terminal:new({cmd = 'k9s --readonly', hidden = true, direction = 'float'}):toggle()<CR>",
    },
  },
  config = function()
    require('toggleterm').setup()
  end,
}
