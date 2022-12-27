vim.cmd.packadd('vim-jetpack')

require('jetpack.packer').add {
  { 'tani/vim-jetpack', opt = 1 },
  { 'lambdalisue/nerdfont.vim' },
  { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' },
  { 'nvim-treesitter/nvim-treesitter-context', require = { 'nvim-treesitter/nvim-treesitter' } },
  { 'tomasiser/vim-code-dark' },
  { 'lukas-reineke/indent-blankline.nvim' },
  { 'nvim-tree/nvim-tree.lua', require = { 'nvim-tree/nvim-web-devicons' } },
  { 'nvim-tree/nvim-web-devicons' },
}

require('rc.nvim-tree')
require('rc.nvim-treesitter')
require('rc.indent-blankline')
