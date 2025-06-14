return {
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
      'nvim-treesitter/nvim-treesitter-context',
    },
    build = ':TSUpdate',
    event = 'BufReadPost',
    config = function()
      -- atlas
      -- See: https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/configs/atlas.lua
      vim.treesitter.language.register('hcl', 'atlas-config')
      vim.treesitter.language.register('hcl', 'atlas-schema-mysql')
      vim.treesitter.language.register('hcl', 'atlas-schema-postgresql')
      vim.treesitter.language.register('hcl', 'atlas-schema-sqlite')
      vim.treesitter.language.register('hcl', 'atlas-schema-clickhouse')
      vim.treesitter.language.register('hcl', 'atlas-schema-mssql')
      vim.treesitter.language.register('hcl', 'atlas-schema-redshift')
      vim.treesitter.language.register('hcl', 'atlas-test')
      vim.treesitter.language.register('hcl', 'atlas-plan')
      ---@diagnostic disable-next-line: missing-fields
      require('nvim-treesitter.configs').setup({
        ensure_installed = {
          'javascript',
          'typescript',
          'go',
          'styled',
        },
        auto_install = true,
        highlight = { enable = true },

        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ['af'] = '@function.outer',
              ['if'] = '@function.inner',
              ['aa'] = '@parameter.outer',
              ['ia'] = '@parameter.inner',
            },
          },
          swap = {
            enable = true,
            swap_next = {
              ['<leader>A'] = '@parameter.inner',
            },
            -- swap_previous = {
            --   ['<leader>A'] = '@parameter.inner',
            -- },
          },
        },

        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            [']m'] = '@function.outer',
            [']]'] = '@class.outer',
          },
          goto_next_end = {
            [']M'] = '@function.outer',
            [']['] = '@class.outer',
          },
          goto_previous_start = {
            ['[m'] = '@function.outer',
            ['[['] = '@class.outer',
          },
          goto_previous_end = {
            ['[M'] = '@function.outer',
            ['[]'] = '@class.outer',
          },
        },
      })
    end,
  },
  {
    'shellRaining/hlchunk.nvim',
    event = 'BufReadPost',
    config = function()
      require('hlchunk').setup({
        chunk = {
          -- 有効にするとfreezeする
          enable = false,
          delay = 0,
        },
        line_num = {
          -- 有効にするとfreezeする
          enable = false,
        },
        blank = {
          enable = false,
        },
        indent = {
          enable = true,
          style = {
            '#E06C75',
            '#E5C07B',
            '#61AFEF',
            '#D19A66',
            '#98C379',
            '#C678DD',
            '#56B6C2',
          },
        },
      })
    end,
  },
  {
    'Wansmer/treesj',
    keys = { '<space>m' },
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require('treesj').setup()
    end,
  },
}
