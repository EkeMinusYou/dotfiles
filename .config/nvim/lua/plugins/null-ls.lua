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
        null_ls.builtins.formatting.goimports.with({
          extra_args = { '-local', 'github.com/groove-x' },
        }),
        null_ls.builtins.diagnostics.staticcheck.with({
          diagnostics_format = '[staticcheck] #{m}\n(#{c})',
        }),
        -- proto
        null_ls.builtins.diagnostics.buf.with({
          diagnostics_format = '[buf] #{m}\n(#{c})',
        }),
        null_ls.builtins.formatting.buf,
        -- lua
        null_ls.builtins.formatting.stylua,
        -- terraform
        null_ls.builtins.diagnostics.terraform_validate,
        null_ls.builtins.formatting.terraform_fmt,
        -- swift
        null_ls.builtins.diagnostics.swiftlint.with({
          diagnostics_format = '[swiftlint] #{m}\n(#{c})',
        }),
        null_ls.builtins.formatting.swiftlint,
        null_ls.builtins.formatting.swift_format.with({
          extra_args = function(params)
            local local_swiftformat = params.cwd .. '/.swift-format'

            if helper.file_exists(local_swiftformat) ~= nil then
              return { '--configuration', local_swiftformat }
            end

            return {}
          end,
        }),
        -- yaml
        null_ls.builtins.formatting.yamlfmt,
      },
    })
  end,
}
