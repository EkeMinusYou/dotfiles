return {
  'xzbdmw/colorful-menu.nvim',
  -- called by cmp
  lazy = true,
  config = function()
    require('colorful-menu').setup()
  end,
}
