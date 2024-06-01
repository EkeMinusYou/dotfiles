return {
  'stevearc/overseer.nvim',
  dependencies = {
    { 'nvim-telescope/telescope.nvim' },
    { 'rcarriga/nvim-notify' },
    { 'stevearc/dressing.nvim' },
  },
  keys = {
    { '<leader>t', '<cmd>OverseerRun<cr>' },
  },
  lazy = true,
  config = function()
    require('overseer').setup({
      strategy = 'jobstart',
      on_create = function()
        vim.cmd('stopinsert')
      end,
    })
  end,
}
