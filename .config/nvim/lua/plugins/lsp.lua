return {
  {
    'neovim/nvim-lspconfig',
    event = 'VeryLazy',
    dependencies = { 'williamboman/mason-lspconfig.nvim' },
  },
  {
    'williamboman/mason.nvim',
    config = function()
      require('mason').setup()
    end,
  },
  {
    'williamboman/mason-lspconfig.nvim',
    event = 'VeryLazy',
    dependencies = { 'neovim/nvim-lspconfig', 'williamboman/mason.nvim' },
    config = function()
      require('mason-lspconfig').setup({
        ensure_installed = {
          'bashls',
          'dockerls',
          'bufls',
          'gopls',
          'jsonls',
          'sumneko_lua',
          'tailwindcss',
          'terraformls',
          'tsserver',
        },
        automatic_installation = true,
      })

      require('mason-lspconfig').setup_handlers({
        function(server_name)
          require('lspconfig')[server_name].setup({})
        end,
        ['sumneko_lua'] = function()
          require('lspconfig').sumneko_lua.setup({
            settings = {
              Lua = {
                diagnostics = { globals = { 'vim' } },
              },
            },
          })
        end,
      })
    end,
  },
  {
    'glepnir/lspsaga.nvim',
    event = 'BufRead',
    keys = {
      { 'gr', '<cmd>Lspsaga lsp_finder<CR>' },
      { 'ga', '<cmd>Lspsaga code_action<CR>' },
    },
    config = function()
      require('lspsaga').setup({})
    end,
  },
}
