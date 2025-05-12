---@type vim.lsp.Config
return {
  -- typescript-toolsの方に任せるので、diagnosticsを無効化
  handlers = {
    ['textDocument/publishDiagnostics'] = function() end,
  },
  on_attach = function(client)
    client.server_capabilities.hoverProvider = false
    client.server_capabilities.completionProvider = nil
    client.server_capabilities.diagnosticProvider = nil
    client.server_capabilities.codeActionProvider = false
    client.server_capabilities.referencesProvider = false
    client.server_capabilities.definitionProvider = false
  end,
}