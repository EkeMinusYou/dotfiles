return {
  'jose-elias-alvarez/null-ls.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  event = 'VeryLazy',
  config = function()
    local null_ls = require('null-ls')
    null_ls.setup({
      sources = {
        -- js,ts
        null_ls.builtins.formatting.prettierd.with({
          condition = function(utils)
            return utils.root_has_file({ '.prettierrc' })
          end,
        }),
        null_ls.builtins.formatting.eslint_d.with({
          condition = function(utils)
            return utils.root_has_file({ '.eslintrc.js' })
          end,
        }),
        null_ls.builtins.formatting.rome.with({
          condition = function(utils)
            return utils.root_has_file({ 'rome.json' })
          end,
        }),
        null_ls.builtins.diagnostics.eslint_d.with({
          condition = function(utils)
            return utils.root_has_file({ '.eslintrc.js' })
          end,
        }),
        -- python
        null_ls.builtins.formatting.black,
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
