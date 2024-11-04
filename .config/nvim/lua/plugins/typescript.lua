return {
  'pmizio/typescript-tools.nvim',
  lazy = true,
  dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
  config = function()
    require('typescript-tools').setup({
      capabilities = require('cmp_nvim_lsp').default_capabilities(),
      root_dir = function(fname)
        local lspconfig = require('lspconfig')
        return lspconfig.util.root_pattern('package.json')(fname)
      end,
      single_file_support = false,

      settings = {
        -- separate_diagnostic_server = true,
        tsserver = '~/.local/share/nvim/mason/bin/typescript-language-server',
        tsserver_plugins = {
          '@styled/typescript-styled-plugin',
        },
      },
    })
  end,
}
