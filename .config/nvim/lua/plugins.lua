vim.cmd('packadd vim-jetpack')

require('jetpack.packer').add {
  {'tani/vim-jetpack', opt = 1},
  {'lambdalisue/fern.vim'},
  {'lambdalisue/fern-git-status.vim'},
  {'lambdalisue/nerdfont.vim'},
  {'lambdalisue/fern-renderer-nerdfont.vim'},
}
