return {
  {
    'MeanderingProgrammer/markdown.nvim',
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('render-markdown').setup({})
    end,
  },
  { 'ixru/nvim-markdown' },
}
