return {
  'pmizio/typescript-tools.nvim',
  dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
  config = function()
    require('typescript-tools').setup({
      settings = {
        -- separate_diagnostic_server = true,
        tsserver_path = '~/.local/share/nvim/mason/bin/typescript-language-server',
        tsserver_plugins = {
          '@styled/typescript-styled-plugin',
          '@vue/typescript-plugin',
        },
      },
    })
  end,
}
