return {
  'akinsho/bufferline.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  event = 'BufReadPost',
  version = 'v3.x',
  keys = {
    { '<leader>j', '<cmd>BufferLinePick<cr>' },
    { '<leader>b', '<cmd>BufferLineCyclePrev<cr>' },
    { '<leader>n', '<cmd>BufferLineCycleNext<cr>' },
    { '<leader>c', '<cmd>BufferLineCloseLeft<cr><cmd>BufferLineCloseRight<cr>' },
  },
  config = {
    options = {
      offsets = {
        {
          filetype = 'NvimTree',
          text = 'File Explorer',
          highlight = 'Directory',
          separator = true,
        },
      },
    },
  },
}
