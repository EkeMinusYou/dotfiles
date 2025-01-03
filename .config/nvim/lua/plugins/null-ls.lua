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

    local h = require('null-ls.helpers')
    local methods = require('null-ls.methods')
    local atlas_fmt = h.make_builtin({
      name = 'atlas_fmt',
      meta = {
        url = 'https://github.com/ariga/atlas',
        description = 'Atlas is a language-agnostic tool for managing and migrating database schemas using modern DevOps principles.',
      },
      method = methods.internal.FORMATTING,
      filetypes = {
        'atlas-config',
        'atlas-schema-mysql',
        'atlas-schema-sqlite',
        'atlas-schema-mariadb',
        'atlas-schema-redshift',
        'atlas-schema-clickhouse',
        'atlas-schema-postgresql',
        'atlas-schema-mssql',
        'atlas-plan',
        'atlas-test',
      },
      generator_opts = {
        command = 'atlas',
        to_temp_file = true,
        from_temp_file = true,
        args = {
          'schema',
          'fmt',
          '$FILENAME',
        },
      },
      factory = h.formatter_factory,
      temp_dir = '/tmp',
    })

    null_ls.setup({
      sources = {
        -- js,ts
        null_ls.builtins.formatting.prettierd.with({
          runtime_condition = function()
            return helper.local_has_file({ '.prettierrc', '.prettierrc.js' })
          end,
          diagnostics_format = '[prettier] #{m}\n(#{c})',
        }),
        require('none-ls.formatting.eslint_d').with({
          runtime_condition = function()
            return helper.local_has_file({ '.eslintrc.js', '.eslintrc.cjs', '.eslintrc.json', 'eslint.config.mjs' })
          end,
          diagnostics_format = '[eslint] #{m}\n(#{c})',
        }),
        null_ls.builtins.formatting.biome.with({
          runtime_condition = function()
            return helper.local_has_file({ 'biome.json' })
          end,
        }),
        require('none-ls.diagnostics.eslint_d').with({
          runtime_condition = function()
            return helper.local_has_file({ '.eslintrc.js', '.eslintrc.cjs', '.eslintrc.json', 'eslint.config.mjs' })
          end,
          diagnostics_format = '[eslint] #{m}\n(#{c})',
        }),
        require('none-ls.code_actions.eslint_d'),
        -- css
        null_ls.builtins.formatting.stylelint.with({
          filetypes = {
            'css',
            'scss',
            'less',
            'sass',
            'html',
            'vue',
            'javascript',
            'javascriptreact',
            'typescript',
            'typescriptreact',
          },
          runtime_condition = function()
            return helper.local_has_file({
              'stylelint.config.js',
              'stylelint.config.mjs',
              '.stylelintrc.json',
              '.stylelintrc',
            })
          end,
          diagnostics_format = '[stylelint] #{m}\n(#{c})',
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
        -- github actions
        null_ls.builtins.diagnostics.actionlint,
        -- proto
        null_ls.builtins.formatting.clang_format.with({
          condition = function()
            return helper.local_has_file({ '.clang-format' })
          end,
        }),
      },
    })
    null_ls.register(atlas_fmt)
  end,
}
