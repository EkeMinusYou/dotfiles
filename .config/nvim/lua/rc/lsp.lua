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

local cmp = require('cmp')
cmp.setup {
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  sources = {
    { name = 'nvim_lsp' }
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ['<C-l>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm { select = true },
  }),
}
