return {
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPost', 'BufWritePost', 'BufNewFile' },
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
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
        -- capabilities = capabilitiesCmpDefault,
        capabilities = capabilities,
        root_dir = function(filename, _)
          local util = require('lspconfig.util')
          -- prefer Package.swift for multi module with swift package manager
          return util.root_pattern('Package.swift')(filename)
            or util.root_pattern('buildServer.json', '*.xcodeproj')(filename)
            or util.find_git_ancestor(filename)
        end,
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
              root_dir = function(fname)
                return lspconfig.util.root_pattern('Chart.yaml')(fname)
              end,
            })
          elseif server_name == 'vtsls' then
            lspconfig.vtsls.setup({
              capabilities = capabilitiesCmpDefault,
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
            lspconfig.biome.setup({
              capabilities = capabilities,
              root_dir = function(fname)
                return lspconfig.util.root_pattern('biome.json')(fname)
              end,
            })
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
    {
      'folke/lazydev.nvim',
      ft = 'lua',
      opts = {
        library = {
          'luvit-meta/library',
        },
      },
    },
    { 'Bilal2453/luvit-meta', lazy = true },
  },
  {
    'glepnir/lspsaga.nvim',
    event = 'LspAttach',
    keys = {
      { '<leader>lr', '<cmd>Lspsaga finder<cr>' },
      { 'gn', '<cmd>Lspsaga rename<cr>' },
      { 'ga', '<cmd>Lspsaga code_action<cr>' },
      { 'gd', '<cmd>Lspsaga goto_definition<cr>' },
      { 'gt', '<cmd>Lspsaga goto_type_definition<cr>' },
      { 'K', '<cmd>Lspsaga hover_doc<cr>' },
    },
    config = function()
      require('lspsaga').setup({
        symbol_in_winbar = {
          enable = false,
        },
        lightbulb = {
          enable = false,
        },
        outline = {
          enable = false,
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
