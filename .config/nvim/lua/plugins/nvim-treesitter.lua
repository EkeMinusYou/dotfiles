return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = "VeryLazy",
    config = function()
      require 'nvim-treesitter.configs'.setup {
        ensure_installed = {
          'tsx',
          'help',
          'lua',
          'dockerfile',
          'proto',
          'javascript',
          'typescript',
          'json',
          'go',
          'html',
          'kotlin',
          'python',
          'sql',
          'toml',
          'ruby',
          'rust',
          'php',
          'perl',
          'fish',
          'make',
          'vim',
          'markdown',
        },
        auto_install = true,

        highlight = { enable = true },
      }
    end,
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    event = 'BufReadPost',
    config = function()
      require('indent_blankline').setup { show_current_context = true, show_current_context_start = true }
    end,
  },
}
