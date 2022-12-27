vim.api.nvim_set_var('fern#renderer', 'nerdfont')
vim.api.nvim_set_var('fern#renderer#nerdfont#indent_markers', 1)
vim.api.nvim_set_var('fern#default_hidden', 1)
vim.api.nvim_create_augroup('glyph-palette', {})
vim.api.nvim_create_autocmd('Filetype', {
  group = 'glyph-palette',
  pattern = 'fern',
  command = 'call glyph_palette#apply()',
})