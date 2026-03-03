return {
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
    config = function()
      require('gitsigns').setup({
        current_line_blame = true,
      })
    end,
  },
  {
    'ruifm/gitlinker.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    lazy = true,
    keys = {
      { '<leader>vl', mode = { 'n', 'v' } },
    },
    config = function()
      require('gitlinker').setup({
        mappings = '<leader>vl',
      })
    end,
  },
  {
    'FabijanZulj/blame.nvim',
    lazy = true,
    event = { 'CmdlineEnter' },
    config = function()
      require('blame').setup()
    end,
  },
}
