local initial_cwd = vim.fn.getcwd()

local function restore()
  vim.cmd('cd ' .. initial_cwd)
  require('nvim-tree.api').tree.close()
  require('dashboard'):instance()
end

return {
  'nvimdev/dashboard-nvim',
  event = 'VimEnter',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  keys = {
    { '<leader>x', restore },
  },
  config = function()
    require('dashboard').setup({
      config = {
        week_header = {
          enable = true,
        },
      },
    })
  end,
}
