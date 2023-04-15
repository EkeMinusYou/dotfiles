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
      require('neodev').setup({
        pathStrict = true,
      })
      require('mason-lspconfig').setup({
        ensure_installed = {
          'bashls',
          'dockerls',
          'bufls',
          'gopls',
          'jsonls',
          'lua_ls',
          'terraformls',
          'vtsls',
        },
        automatic_installation = true,
      })

      require('mason-lspconfig').setup_handlers({
        function(server_name)
          local lspconfig = require('lspconfig')
          if server_name == 'lua_ls' then
            lspconfig.lua_ls.setup({
              settings = {
                Lua = {
                  completion = {
                    callSnippet = 'Replace',
                  },
                },
              },
            })
          else
            lspconfig[server_name].setup({})
          end
        end,
      })
    end,
  },
  {
    'glepnir/lspsaga.nvim',
    event = 'BufRead',
    keys = {
      { 'gr', '<cmd>Lspsaga lsp_finder<cr>' },
      { 'gn', '<cmd>Lspsaga rename<cr>' },
      { 'ga', '<cmd>Lspsaga code_action<cr>' },
      { '<leader>o', '<cmd>Lspsaga outline<cr>' },
    },
    config = function()
      require('lspsaga').setup({
        lightbulb = {
          enable = false,
        },
        outline = {
          win_width = 50,
          keys = {
            jump = '<cr>',
            quit = 'q',
          },
        },
      })
    end,
  },
  {
    'stevearc/dressing.nvim',
    event = 'VeryLazy',
  },
}
