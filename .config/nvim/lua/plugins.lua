vim.cmd('packadd vim-jetpack')

require('jetpack.packer').add {
  {'tani/vim-jetpack', opt = 1},
  {'lambdalisue/fern.vim'},
  {'lambdalisue/fern-git-status.vim'},
  {'lambdalisue/nerdfont.vim'},
  {'lambdalisue/fern-renderer-nerdfont.vim'},
  {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'},
  {'nathanaelkane/vim-indent-guides'},
}

-- fern
vim.api.nvim_set_var('fern#renderer', 'nerdfont')
vim.api.nvim_set_var('fern#renderer#nerdfont#indent_markers', true)
vim.api.nvim_set_var('fern#default_hidden', 1)