return {
  {
    'rebelot/kanagawa.nvim',
    lazy = false,
    config = function()
      vim.cmd([[colorscheme kanagawa-wave]])
    end,
  },
  {
    'folke/tokyonight.nvim',
    lazy = true,
    config = function()
      vim.cmd([[colorscheme tokyonight-night]])
    end,
  },
}
