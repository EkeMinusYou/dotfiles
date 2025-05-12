---@type vim.lsp.Config
return {
  root_dir = function(bufnr, callback)
    return callback(require('lspconfig').util.root_pattern('biome.json', 'biome.toml', '.git')(bufnr))
  end,
}