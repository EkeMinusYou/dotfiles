return {
  'jose-elias-alvarez/null-ls.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  -- event = 'VeryLazy',
  config = function()
    local null_ls = require('null-ls')
    null_ls.setup({
      sources = {
        -- js,ts
        null_ls.builtins.formatting.eslint_d,
        null_ls.builtins.diagnostics.eslint_d,
        null_ls.builtins.formatting.prettierd,
        -- go
        null_ls.builtins.formatting.gofmt,
        null_ls.builtins.formatting.goimports,
        null_ls.builtins.diagnostics.staticcheck,
        -- proto
        null_ls.builtins.diagnostics.buf,
        -- lua
        null_ls.builtins.formatting.stylua,
      },
    })
  end,
}
