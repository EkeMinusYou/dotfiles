vim.cmd('packadd vim-jetpack')

require('jetpack.packer').add {
  { 'tani/vim-jetpack', opt = 1 },
  { 'lambdalisue/fern.vim' },
  { 'lambdalisue/fern-git-status.vim' },
  { 'lambdalisue/nerdfont.vim' },
  { 'lambdalisue/fern-renderer-nerdfont.vim' },
  { 'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require 'nvim-treesitter.configs'.setup {
        highlight = { enable = true }
      }
    end
  },
  { 'nathanaelkane/vim-indent-guides' },
  { 'lambdalisue/glyph-palette.vim' },
  { 'lambdalisue/fern-hijack.vim' },
}

require('rc.fern')