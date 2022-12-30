require('mason').setup()

local mason_lspconfig = require('mason-lspconfig')
mason_lspconfig.setup({
  automatic_installation = true
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()

mason_lspconfig.setup_handlers({ function(server)
  require('lspconfig')[server].setup({
    capabilities = capabilities,
  })
end })
