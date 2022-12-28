vim.cmd.packadd('vim-jetpack')

require('jetpack.packer').add {
  { 'tani/vim-jetpack', opt = 1 },

  { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' },
  { 'nvim-treesitter/nvim-treesitter-context', requires = { 'nvim-treesitter/nvim-treesitter' } },
  { 'p00f/nvim-ts-rainbow' },
  { 'lukas-reineke/indent-blankline.nvim' },
  { 'nvim-tree/nvim-tree.lua', requires = { 'nvim-tree/nvim-web-devicons' } },
  { 'nvim-lualine/lualine.nvim', requires = { 'nvim-tree/nvim-web-devicons' } },
  { 'nvim-tree/nvim-web-devicons' },
  { 'nvim-lua/plenary.nvim' },
  { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' }, tag = '0.1.x' },
  { 'folke/which-key.nvim' },
  { "akinsho/toggleterm.nvim" },

  -- theme plugins
  { 'tomasiser/vim-code-dark' },
  { 'rebelot/kanagawa.nvim' },
  { 'folke/tokyonight.nvim' },
}

require('rc.nvim-tree')
require('rc.nvim-treesitter')
require('rc.indent-blankline')
require('rc.lualine')
require('rc.toggleterm')
