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
    require('snacks').setup({
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
              border = 'rounded',
              title = '{source} {live}',
              title_pos = 'center',
              { win = 'input', height = 1, border = 'bottom' },
              { win = 'list', border = 'none' },
            },
            { win = 'preview', border = 'rounded', width = 0.5 },
          },
        },
      },
    })
  end,
}
