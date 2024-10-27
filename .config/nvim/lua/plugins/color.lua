return {
  { 'nvchad/volt', lazy = true },
  { 'nvchad/minty', lazy = true },
  {
    'brenoprata10/nvim-highlight-colors',
    event = { 'BufReadPost', 'BufWritePost', 'BufNewFile' },
    config = function()
      require('nvim-highlight-colors').setup({
        render = 'virtual',
        virtual_symbol_suffix = '',
        enable_tailwind = true,
      })
    end,
  },
}
