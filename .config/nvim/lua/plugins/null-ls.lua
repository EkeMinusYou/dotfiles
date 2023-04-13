local function exists_in_dir(filename, dir)
  local files = vim.fn.readdir(dir)
  return vim.tbl_contains(files, filename)
end

local function local_has_file(filenames, levels_up)
  if levels_up == nil then
    levels_up = 5
  end
  local dir = vim.fn.expand('%:p:h')
  for i = 1, levels_up + 1 do
    for _, filename in ipairs(filenames) do
      if exists_in_dir(filename, dir) then
        return true
      end
    end
    dir = vim.fn.fnamemodify(dir, ':h')
  end
  return false
end

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
            return local_has_file({ '.prettierrc' })
          end,
        }),
        null_ls.builtins.formatting.eslint_d.with({
          condition = function(utils)
            return local_has_file({ '.eslintrc.js', '.eslintrc.cjs' })
          end,
        }),
        null_ls.builtins.formatting.rome.with({
          condition = function(utils)
            return local_has_file({ 'rome.json' })
          end,
        }),
        null_ls.builtins.diagnostics.eslint_d.with({
          condition = function(utils)
            return local_has_file({ '.eslintrc.js', '.eslintrc.cjs' })
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
      },
    })
  end,
}
