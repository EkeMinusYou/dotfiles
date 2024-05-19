return {
  'pcolladosoto/tinygo.nvim',
  event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
  config = function()
    local target = os.getenv('TINYGO_TARGET')
    if target ~= nil then
      require('tinygo').setup()
      vim.api.nvim_command('TinyGoSetTarget ' .. target)
    end
  end,
}
