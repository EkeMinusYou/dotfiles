return {
  'akinsho/bufferline.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  event = 'BufReadPost',
  version = 'v3.x',
  keys = {
    { '<C-S-u>', '<cmd>BufferLinePick<cr>' },
    { '<C-S-o>', '<cmd>BufferLineCyclePrev<cr>' },
    { '<C-S-i>', '<cmd>BufferLineCycleNext<cr>' },
    { '<C-S-p>', '<cmd>BufferLineCloseLeft<cr><cmd>BufferLineCloseRight<cr>' },
  },
  config = function()
    require('bufferline').setup({
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
    })
  end,
}
