return {
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPost', 'BufWritePost', 'BufNewFile' },
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'hrsh7th/cmp-nvim-lsp',
      'b0o/schemastore.nvim',
      'rachartier/tiny-inline-diagnostic.nvim',
      { 'nvim-java/nvim-java', event = 'VeryLazy' },
    },
    config = function()
      require('mason').setup()
      local mason_lspconfig = require('mason-lspconfig')
      local ensure_installed = {
        'bashls',
        'biome',
        'css_variables',
        'cucumber_language_server',
        'denols',
        'dockerls',
        'emmet_language_server',
        'gopls',
        'helm_ls',
        'html',
        'jsonls',
        'lua_ls',
        'markdown_oxide',
        'omnisharp',
        'prismals',
        'pyright',
        'sqls',
        'stylelint_lsp',
        'tailwindcss',
        'terraformls',
        'ts_ls',
        'typos_lsp',
        'vimls',
        'yamlls',
      }
      mason_lspconfig.setup({
        ensure_installed = ensure_installed,
        automatic_installation = true,
        automatic_enable = false,
      })

      vim.lsp.config('*', {
        capabilities = vim.lsp.protocol.make_client_capabilities(),
      })

      vim.lsp.enable(ensure_installed)
      vim.lsp.enable({ 'atlas', 'actionlint', 'clang-format', 'yamlfmt', 'sourcekit', 'protols', 'eslint' })
      vim.lsp.enable('zshcs')
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
