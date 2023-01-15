return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  event = 'VeryLazy',
  config = function()
    vim.opt.laststatus = 3
    require('lualine').setup({
      extensions = {
        'nvim-tree',
        'toggleterm',
      },
      options = {
        globalstatus = true,
      },
    })
  end,
}
