return {
  'windwp/nvim-autopairs',
  event = 'BufReadPost',
  config = function()
    require('nvim-autopairs').setup({
      map_c_h = true,
      map_c_w = true,
    })
  end,
}
