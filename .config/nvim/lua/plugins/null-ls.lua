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
          runtime_condition = function()
            return helper.local_has_file({ '.prettierrc', '.prettierrc.js' })
          end,
        }),
        require('none-ls.formatting.eslint_d').with({
          runtime_condition = function()
            return helper.local_has_file({
              '.eslintrc.js',
              '.eslintrc.cjs',
              '.eslintrc.json',
              'eslint.config.mjs',
              'eslint.config.js',
            })
          end,
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
        null_ls.builtins.diagnostics.staticcheck,
        null_ls.builtins.formatting.stylua,
        -- terraform
        null_ls.builtins.diagnostics.terraform_validate,
        null_ls.builtins.formatting.terraform_fmt,
        -- swift
        null_ls.builtins.diagnostics.swiftlint,
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
        -- atlas
        null_ls.builtins.formatting.atlas_fmt.with({
          temp_dir = '/tmp',
        }),
        -- sql
        null_ls.builtins.diagnostics.sqruff.with({
          condition = function()
            return helper.local_has_file({ '.sqruff' })
          end,
          diagnostics_format = '[sqruff] #{m}\n(#{c})',
        }),
        null_ls.builtins.formatting.sqruff.with({
          condition = function()
            return helper.local_has_file({ '.sqruff' })
          end,
        }),
      },
    })
  end,
}
