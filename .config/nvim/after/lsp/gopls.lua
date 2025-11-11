---@type vim.lsp.Config
return {
  settings = {
    gopls = {
      analyses = {
        ST1003 = false,
      },
      staticcheck = true,
    },
  },
}
