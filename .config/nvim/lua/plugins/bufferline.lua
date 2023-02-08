return {
  'akinsho/bufferline.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  event = 'BufReadPost',
  version = 'v3.x',
  keys = {
    { '<m-u>', '<cmd>BufferLinePick<cr>' },
    { '<m-o>', '<cmd>BufferLineCyclePrev<cr>' },
    { '<m-i>', '<cmd>BufferLineCycleNext<cr>' },
    { '<m-p>', '<cmd>BufferLineCloseLeft<cr><cmd>BufferLineCloseRight<cr>' },
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
