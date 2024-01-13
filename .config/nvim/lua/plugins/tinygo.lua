return {
  'pcolladosoto/tinygo.nvim',
  event = 'VeryLazy',
  config = function()
    require('tinygo').setup()
    local defaultTarget = 'arduino'
    vim.api.nvim_command('TinyGoSetTarget ' .. defaultTarget)
  end,
}
