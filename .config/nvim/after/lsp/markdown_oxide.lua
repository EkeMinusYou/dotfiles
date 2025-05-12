---@type vim.lsp.Config
return {
  root_markers = {
    '.projectroot',
    '.moxide.toml',
    '.git',
  },
  workspace_required = true,
}