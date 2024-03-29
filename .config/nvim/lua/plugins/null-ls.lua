local helper = require('utils.helper')

return {
  'nvimtools/none-ls.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvimtools/none-ls-extras.nvim',
  },
  event = 'LspAttach',
  config = function()
    local null_ls = require('null-ls')
    null_ls.setup({
      sources = {
        -- js,ts
        null_ls.builtins.formatting.prettierd.with({
          condition = function()
            return helper.local_has_file({ '.prettierrc', '.prettierrc.js' })
          end,
          diagnostics_format = '[prettier] #{m}\n(#{c})',
        }),
        require('none-ls.formatting.eslint_d').with({
          condition = function()
            return helper.local_has_file({ '.eslintrc.js', '.eslintrc.cjs' })
          end,
          diagnostics_format = '[eslint] #{m}\n(#{c})',
        }),
        null_ls.builtins.formatting.biome.with({
          condition = function()
            return helper.local_has_file({ 'biome.json' })
          end,
          diagnostics_format = '[biome] #{m}\n(#{c})',
        }),
        require('none-ls.diagnostics.eslint_d').with({
          condition = function()
            return helper.local_has_file({ '.eslintrc.js', '.eslintrc.cjs' })
          end,
          diagnostics_format = '[eslint] #{m}\n(#{c})',
        }),
        -- python
        null_ls.builtins.formatting.black.with({
          prefer_local = '.venv/bin',
        }),
        null_ls.builtins.diagnostics.mypy.with({
          prefer_local = '.venv/bin',
        }),
        -- go
        null_ls.builtins.formatting.gofmt,
        null_ls.builtins.formatting.goimports,
        null_ls.builtins.diagnostics.staticcheck.with({
          diagnostics_format = '[staticcheck] #{m}\n(#{c})',
        }),
        -- proto
        null_ls.builtins.diagnostics.buf,
        -- lua
        null_ls.builtins.formatting.stylua,
        -- terraform
        null_ls.builtins.diagnostics.terraform_validate,
        null_ls.builtins.formatting.terraform_fmt,
        -- swift
        null_ls.builtins.formatting.swiftformat.with({
          command = 'swift-format',
        }),
      },
    })
  end,
}
