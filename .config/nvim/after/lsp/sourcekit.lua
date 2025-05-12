---@type vim.lsp.Config
return {
  root_markers = {
    'Package.swift',
    'buildServer.json',
    '*.xcodeproj',
  },
  workspace_required = true,
}
