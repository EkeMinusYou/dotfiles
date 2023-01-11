return {
  'akinsho/bufferline.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  event = 'BufReadPost',
  version = 'v3.x',
  keys = {
    { '<leader>bj', '<cmd>BufferLinePick<cr>' },
    { '<leader>bb', '<cmd>BufferLineCyclePrev<cr>' },
    { '<leader>bn', '<cmd>BufferLineCycleNext<cr>' },
    { '<leader>bc', '<cmd>BufferLineCloseLeft<cr><cmd>BufferLineCloseRight<cr>' },
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
