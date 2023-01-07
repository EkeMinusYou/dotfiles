return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  event = 'BufReadPost',
  config = function()
    require('lualine').setup({
      options = {
        globalstatus = true,
        disabled_filetypes = { 'NvimTree', 'alpha' },
      },
    })
  end,
}
