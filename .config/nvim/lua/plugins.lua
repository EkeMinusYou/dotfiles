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

-- fern
vim.api.nvim_set_var('fern#renderer', 'nerdfont')
vim.api.nvim_set_var('fern#renderer#nerdfont#indent_markers', 1)
vim.api.nvim_set_var('fern#default_hidden', 1)
vim.api.nvim_create_augroup('glyph-palette', {})
vim.api.nvim_create_autocmd('Filetype', {
  group = 'glyph-palette',
  pattern = 'fern',
  command = 'call glyph_palette#apply()',
})
