vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = { '*.js', '*.jsx', '*.ts', '*.tsx', '*.go' },
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
})
