vim.cmd.packadd('vim-jetpack')

require('jetpack.packer').add {
  { 'tani/vim-jetpack', opt = 1 },

  { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' },
  { 'nvim-treesitter/nvim-treesitter-context', require = { 'nvim-treesitter/nvim-treesitter' } },
  { 'lukas-reineke/indent-blankline.nvim' },
  { 'nvim-tree/nvim-tree.lua', require = { 'nvim-tree/nvim-web-devicons' } },
  { 'nvim-tree/nvim-web-devicons' },

  -- theme plugins
  { 'tomasiser/vim-code-dark' },
  { 'folke/tokyonight.nvim'},
  { 'rebelot/kanagawa.nvim' },
}

require('rc.nvim-tree')
require('rc.nvim-treesitter')
require('rc.indent-blankline')
