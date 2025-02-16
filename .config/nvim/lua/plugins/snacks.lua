return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  keys = {
    -- {
    --   '<leader>ff',
    --   function()
    --     Snacks.picker.files()
    --   end,
    --   desc = 'Find Files',
    -- },
    -- {
    --   '<leader>fg',
    --   function()
    --     Snacks.picker.grep()
    --   end,
    --   desc = 'Grep',
    -- },
  },
  config = function()
    local snacks = require('snacks')
    snacks.setup({
      input = { enabled = true },
      styles = {
        input = {
          relative = 'cursor',
        },
      },
      ---@class snacks.dashboard.Config
      dashboard = {},
      ---@class snacks.picker.Config
      picker = {
        sources = {
          files = {
            hidden = true,
          },
          grep = {
            hidden = true,
          },
        },
        formatters = {
          file = {
            filename_first = true,
          },
        },
        layout = {
          layout = {
            box = 'horizontal',
            width = 0.8,
            min_width = 120,
            height = 0.9,
            {
              box = 'vertical',
              { win = 'input', height = 1, border = 'rounded', title = '{source} {live}', title_pos = 'center' },
              { win = 'list', title = ' Results ', title_pos = 'center', border = 'rounded' },
            },
            {
              win = 'preview',
              width = 0.45,
              border = 'rounded',
              title = ' Preview ',
              title_pos = 'center',
            },
          },
        },
      },
    })
  end,
}
