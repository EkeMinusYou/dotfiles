return {
  'jose-elias-alvarez/null-ls.nvim',
  dependencies = {'nvim-lua/plenary.nvim'},
  config = function()
    local null_ls = require('null-ls')
    null_ls.setup {
      sources = {
        null_ls.builtins.formatting.eslint,
        null_ls.builtins.diagnostics.eslint,
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.formatting.gofmt,
        null_ls.builtins.formatting.goimports,
        null_ls.builtins.diagnostics.buf,
        null_ls.builtins.diagnostics.staticcheck,
        null_ls.builtins.formatting.lua_format.with {
          extra_args = {
            '--column-limit=120',
            '--indent-width=2',
            '--no-use-tab',
            '--continuation-indent-width=2',
            '--chop-down-table',
            '--chop-down-kv-table',
            '--chop-down-parameter',
            '--no-keep-simple-control-block-one-line',
            '--no-keep-simple-function-one-line',
            '--extra-sep-at-table-end',
            '--double-quote-to-single-quote',
            '--align-table-field',
          },
        },
      },
    }
  end,
}
