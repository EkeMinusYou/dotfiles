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
    local terminal = require('toggleterm.terminal').Terminal
    lazygit = terminal:new({
      cmd = 'lazygit',
      dir = 'git_dir',
      hidden = true,
      direction = 'float',
      on_open = function(term)
        vim.api.nvim_buf_set_keymap(term.bufnr, 't', 'q', '<CMD>close<CR>', { noremap = true, silent = true })
      end,
    })
  end,
}
