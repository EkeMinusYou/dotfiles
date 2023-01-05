vim.api.nvim_create_autocmd('bufwritepre', {
  pattern = {'*.js', '*.jsx', '*.ts', '*.tsx', '*.go'},
  callback = function()
    vim.lsp.buf.format {async = false}
  end,
})

vim.api.nvim_create_autocmd('VimEnter', {
  callback = function()
    vim.cmd('NvimTreeToggle')
  end,
})
