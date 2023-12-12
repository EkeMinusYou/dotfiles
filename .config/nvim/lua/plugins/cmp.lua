return {
  'hrsh7th/nvim-cmp',
  event = { 'InsertEnter', 'CmdlineEnter' },
  dependencies = {
    { 'hrsh7th/cmp-nvim-lsp', dependencies = { 'neovim/nvim-lspconfig' } },
    { 'hrsh7th/cmp-buffer' },
    { 'hrsh7th/cmp-path' },
    { 'hrsh7th/cmp-cmdline' },
    { 'hrsh7th/cmp-vsnip' },
    { 'hrsh7th/cmp-nvim-lsp-signature-help' },
    { 'hrsh7th/cmp-nvim-lsp-document-symbol' },
    { 'hrsh7th/vim-vsnip-integ' },
    { 'EkeMinusYou/vim-vsnip' },
    { 'onsails/lspkind.nvim' },
  },
  config = function()
    local cmp = require('cmp')
    local lspkind = require('lspkind')
    cmp.setup.cmdline({ '/', '?' }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = 'nvim_lsp_document_symbol' },
      }, {
        { name = 'buffer' },
      }),
    })
    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = 'path' },
      }, {
        { name = 'cmdline' },
      }),
    })
    cmp.setup({
      snippet = {
        expand = function(args)
          vim.fn['vsnip#anonymous'](args.body)
        end,
      },
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'vsnip' },
        { name = 'nvim_lsp_signature_help' },
        { name = 'path' },
      }, {
        { name = 'buffer', keyword_length = 2 },
      }),
      window = {
        completion = cmp.config.window.bordered({
          border = 'single',
        }),
        documentation = cmp.config.window.bordered({
          border = 'single',
        }),
      },
      mapping = cmp.mapping.preset.insert({
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-l>'] = cmp.mapping.complete({}),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
      }),
      formatting = {
        format = lspkind.cmp_format({
          mode = 'symbol_text',
        }),
      },
    })
  end,
}
