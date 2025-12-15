---@type vim.lsp.Config
return {
  settings = {
    gopls = {
      analyses = {
        ST1000 = false,
        ST1003 = false,
      },
      staticcheck = true,
    },
  },
}
