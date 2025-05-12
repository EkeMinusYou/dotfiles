return {
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPost', 'BufWritePost', 'BufNewFile' },
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'hrsh7th/cmp-nvim-lsp',
      'pmizio/typescript-tools.nvim',
      'b0o/schemastore.nvim',
      'rachartier/tiny-inline-diagnostic.nvim',
      'nvim-java/nvim-java',
    },
    config = function()
      require('mason').setup()
      local mason_lspconfig = require('mason-lspconfig')
      mason_lspconfig.setup({
        ensure_installed = {
          'bashls',
          'dockerls',
          'jsonls',
          'lua_ls',
          'denols',
          'biome',
          'terraformls',
          'yamlls',
        },
        automatic_installation = true,
      })

      vim.lsp.config('*', {
        capabilities = vim.lsp.protocol.make_client_capabilities(),
      })

      local lspconfig = require('lspconfig')
      -- Setup LSP
      lspconfig.sourcekit.setup({
        -- ref: https://www.swift.org/documentation/articles/zero-to-swift-nvim.html
        root_dir = function(filename, _)
          local util = require('lspconfig.util')
          -- prefer Package.swift for multi module with swift package manager
          return util.root_pattern('Package.swift')(filename)
            or util.root_pattern('buildServer.json', '*.xcodeproj')(filename)
            or vim.fs.dirname(vim.fs.find('.git', { path = filename, upward = true })[1])
        end,
      })
      lspconfig.atlas.setup({})
      -- Setup LSP by mason
      mason_lspconfig.setup_handlers({
        function(server_name)
          lspconfig[server_name].setup({})
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
      { 'gt', '<cmd>Lspsaga goto_type_definition<cr>' },
      { 'K', '<cmd>Lspsaga hover_doc<cr>' },
      { 'ga', '<cmd>Lspsaga code_action<cr>' },
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
    'rachartier/tiny-inline-diagnostic.nvim',
    lazy = true,
    config = function()
      require('tiny-inline-diagnostic').setup({
        options = {
          show_source = true,
          use_icons_from_diagnostic = true,
          multilines = {
            enabled = true,
            always_show = true,
          },
        },
      })
      vim.diagnostic.config({ virtual_text = false })
    end,
  },
}
