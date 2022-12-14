return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = 'BufReadPost',
    config = function()
      require('nvim-treesitter.configs').setup({
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
      })
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    event = 'BufReadPost',
    config = function()
      require('nvim-treesitter.configs').setup({
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ['af'] = '@function.outer',
              ['if'] = '@function.inner',
            },
            include_surrounding_whitespace = true,
          },
          swap = {
            enable = true,
            swap_next = {
              ['<leader>a'] = '@parameter.inner',
            },
            swap_previous = {
              ['<leader>A'] = '@parameter.inner',
            },
          },
          move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
              [']m'] = '@function.outer',
            },
            goto_next_end = {
              [']M'] = '@function.outer',
            },
            goto_previous_start = {
              ['[m'] = '@function.outer',
            },
            goto_previous_end = {
              ['[M'] = '@function.outer',
            },
          },
        },
      })
    end,
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    event = 'BufReadPost',
    config = function()
      require('indent_blankline').setup({ show_current_context = true, show_current_context_start = true })
    end,
  },
}
