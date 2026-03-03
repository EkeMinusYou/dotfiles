---@type vim.lsp.Config
return {
  settings = {
    java = {
      configuration = {
        runtimes = {
          {
            name = 'Java',
            path = os.getenv('JAVA_HOME'),
            default = true,
          },
        },
      },
    },
  },
}