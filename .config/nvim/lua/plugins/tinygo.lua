return {
  'pcolladosoto/tinygo.nvim',
  event = 'VeryLazy',
  config = function()
    require('tinygo').setup()

    local defaultTarget = os.getenv('TINYGO_TARGET')
    if defaultTarget ~= nil then
      vim.api.nvim_command('TinyGoSetTarget ' .. defaultTarget)
    end
  end,
}
