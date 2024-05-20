local function lazygit()
  local terminal = require('toggleterm.terminal').Terminal
  terminal
    :new({
      cmd = 'lazygit',
      dir = 'git_dir',
      hidden = true,
      direction = 'float',
    })
    :toggle()
end

return {
  'akinsho/toggleterm.nvim',
  lazy = true,
  keys = {
    { '<leader>g', lazygit },
  },
  config = function()
    require('toggleterm').setup()
  end,
}
