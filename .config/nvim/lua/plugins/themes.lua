return {
  {
    'rebelot/kanagawa.nvim',
    lazy = false,
    config = function()
      -- vim.cmd([[colorscheme kanagawa-wave]])
    end,
  },
  {
    'folke/tokyonight.nvim',
    lazy = false,
    config = function()
      -- vim.cmd([[colorscheme tokyonight-night]])
    end,
  },
  {
    'uloco/bluloco.nvim',
    lazy = false,
    dependencies = { 'rktjmp/lush.nvim' },
    config = function()
      -- vim.cmd([[colorscheme bluloco]])
    end,
  },
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    lazy = false,
    config = function()
      vim.cmd([[colorscheme catppuccin-mocha]])
    end,
  },
  {
    'kvrohit/rasmus.nvim',
    lazy = false,
    config = function()
      -- vim.cmd([[colorscheme rasmus]])
    end,
  },
}
