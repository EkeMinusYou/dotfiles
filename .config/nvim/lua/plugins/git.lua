return {
  {
    'lewis6991/gitsigns.nvim',
    event = 'BufReadPost',
    config = function()
      require('gitsigns').setup({
        current_line_blame = true,
      })
    end,
  },
  {
    'ruifm/gitlinker.nvim',
    event = 'VeryLazy',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('gitlinker').setup({
        mappings = '<leader>l',
      })
    end,
  },
}
