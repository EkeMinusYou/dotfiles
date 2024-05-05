local helper = require('utils.helper')

return {
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPost', 'BufWritePost', 'BufNewFile' },
    dependencies = {
      'folke/neodev.nvim',
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
      require('neodev').setup({
        pathStrict = true,
      })
      require('mason').setup()
      local mason_lspconfig = require('mason-lspconfig')
      mason_lspconfig.setup({
        ensure_installed = {
          'bashls',
          'dockerls',
          'bufls',
          'gopls',
          'jsonls',
          'lua_ls',
          'vtsls',
          'denols',
          'biome',
          'terraformls',
        },
        automatic_installation = true,
      })

      local lspconfig = require('lspconfig')
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      -- Setup LSP
      lspconfig.sourcekit.setup({
        capabilities = capabilities,
      })
      -- Setup LSP by mason
      mason_lspconfig.setup_handlers({
        function(server_name)
          if server_name == 'lua_ls' then
            lspconfig.lua_ls.setup({
              capabilities = capabilities,
              settings = {
                Lua = {
                  completion = {
                    callSnippet = 'Replace',
                  },
                },
              },
            })
          elseif server_name == 'helm_ls' then
            lspconfig.helm_ls.setup({
              capabilities = capabilities,
              filetypes = { 'helm', 'yaml' },
              root_dir = function(fname)
                return lspconfig.util.root_pattern('Chart.yaml')(fname)
              end,
            })
          elseif server_name == 'vtsls' then
            lspconfig.vtsls.setup({
              capabilities = capabilities,
              root_dir = function(fname)
                return lspconfig.util.root_pattern('package.json')(fname)
              end,
              single_file_support = false,
            })
          elseif server_name == 'denols' then
            lspconfig.denols.setup({
              capabilities = capabilities,
              root_dir = function(fname)
                return lspconfig.util.root_pattern('deno.json')(fname)
              end,
            })
          elseif server_name == 'biome' then
            -- do nothing. only use null-ls
          else
            lspconfig[server_name].setup({
              capabilities = capabilities,
            })
          end
        end,
      })
    end,
  },
  {
    'glepnir/lspsaga.nvim',
    event = 'LspAttach',
    keys = {
      { 'gr', '<cmd>Lspsaga finder<cr>' },
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
            quit = 'q',
          },
        },
        rename = {
          auto_save = true,
        },
      })
    end,
  },
  {
    'stevearc/dressing.nvim',
    event = 'LspAttach',
  },
}
