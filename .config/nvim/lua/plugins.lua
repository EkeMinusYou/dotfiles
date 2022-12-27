vim.cmd.packadd('vim-jetpack')

require('jetpack.packer').add {
  { 'tani/vim-jetpack', opt = 1 },
  { 'lambdalisue/fern.vim' },
  { 'lambdalisue/fern-git-status.vim' },
  { 'lambdalisue/nerdfont.vim' },
  { 'lambdalisue/fern-renderer-nerdfont.vim' },
  { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' },
  { 'nvim-treesitter/nvim-treesitter-context', require = { 'nvim-treesitter/nvim-treesitter' } },
  { 'lambdalisue/glyph-palette.vim' },
  { 'lambdalisue/fern-hijack.vim' },
  { 'tomasiser/vim-code-dark' },
  { "lukas-reineke/indent-blankline.nvim" },
}

require('rc.fern')
require('rc.nvim-treesitter')
