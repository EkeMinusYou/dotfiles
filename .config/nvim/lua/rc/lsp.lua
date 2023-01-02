require('mason').setup()

require('mason-lspconfig').setup({
  automatic_installation = true
})

require("mason-lspconfig").setup_handlers {
  function(server_name)
    require("lspconfig")[server_name].setup {}
  end
}

-- lua
require 'lspconfig'.sumneko_lua.setup {
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' },
      },
    },
  },
}
