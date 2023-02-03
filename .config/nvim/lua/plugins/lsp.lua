return {
  {
    'neovim/nvim-lspconfig',
    event = 'VeryLazy',
    dependencies = {
      'williamboman/mason-lspconfig.nvim',
    },
  },
  {
    'williamboman/mason.nvim',
    event = 'VeryLazy',
    config = function()
      require('mason').setup()
    end,
  },
  {
    'williamboman/mason-lspconfig.nvim',
    event = 'VeryLazy',
    dependencies = {
      'neovim/nvim-lspconfig',
      'williamboman/mason.nvim',
      'folke/neodev.nvim',
    },
    config = function()
      require('neodev').setup()
      require('mason-lspconfig').setup({
        ensure_installed = {
          'bashls',
          'dockerls',
          'bufls',
          'gopls',
          'jsonls',
          'sumneko_lua',
          'terraformls',
          'tsserver',
        },
        automatic_installation = true,
      })

      require('mason-lspconfig').setup_handlers({
        function(server_name)
          require('lspconfig')[server_name].setup({})
        end,
      })
    end,
  },
  {
    'glepnir/lspsaga.nvim',
    event = 'BufRead',
    keys = {
      { 'gr', '<cmd>Lspsaga lsp_finder<CR>' },
      { 'gn', '<cmd>Lspsaga rename<CR>' },
      { 'ga', '<cmd>Lspsaga code_action<CR>' },
    },
    config = function()
      require('lspsaga').setup({
        lightbulb = {
          enable = false,
        },
      })
    end,
  },
  {
    'stevearc/dressing.nvim',
    event = 'VeryLazy',
  },
}
