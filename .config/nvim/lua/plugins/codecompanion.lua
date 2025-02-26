return {
  'olimorris/codecompanion.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  config = function()
    require('codecompanion').setup({
      opts = {
        language = 'Japanese',
      },
      display = {
        chat = {
          window = {
            layout = 'vertical',
            position = 'right',
            border = 'single',
            height = 0.8,
            width = 0.45,
            relative = 'editor',
            opts = {
              breakindent = true,
              cursorcolumn = false,
              cursorline = false,
              foldcolumn = '0',
              linebreak = true,
              list = false,
              numberwidth = 1,
              signcolumn = 'no',
              spell = false,
              wrap = true,
            },
          },
        },
      },
      strategies = {
        chat = {
          adapter = 'ollama',
        },
        inline = {
          adapter = 'ollama',
        },
        agent = {
          adapter = 'ollama',
        },
      },
      adapters = {
        ollama = function()
          return require('codecompanion.adapters').extend('ollama', {
            env = {
              url = 'http://192.168.1.9:11434',
            },
            headers = {
              ['Content-Type'] = 'application/json',
            },
            parameters = {
              sync = true,
            },
            schema = {
              model = {
                default = 'deepseek-r1:14B',
              },
            },
          })
        end,
      },
    })
  end,
}
