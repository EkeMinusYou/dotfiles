local helper = {}

local function exists_in_dir(filename, dir)
  local files = vim.fn.readdir(dir)
  return vim.tbl_contains(files, filename)
end

helper.local_has_file = function(filenames)
  local dir = vim.fn.expand('%:p:h')
  local cwd = vim.fn.getcwd()
  while true do
    for _, filename in ipairs(filenames) do
      if exists_in_dir(filename, dir) then
        return true
      end
    end
    if dir == '' or dir == cwd or dir == '/' then
      break
    end
    dir = vim.fn.fnamemodify(dir, ':h')
  end
  return exists_in_dir(filenames, cwd)
end

-- See: https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Avoiding-LSP-formatting-conflicts
helper.lsp_formatting = function(config)
  vim.lsp.buf.format({
    filter = function(client)
      return client.name == 'null-ls'
    end,
    async = config.async,
    timeout_ms = config.timeout_ms,
  })
end

return helper
