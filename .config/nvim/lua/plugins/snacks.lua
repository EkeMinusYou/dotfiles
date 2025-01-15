return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  -- keys = {
  --   {
  --     '<leader>ff',
  --     function()
  --       ---@diagnostic disable-next-line: missing-fields
  --       Snacks.picker.files({ hidden = true })
  --     end,
  --     desc = 'Find Files',
  --   },
  --   {
  --     '<leader>fg',
  --     function()
  --       ---@diagnostic disable-next-line: missing-fields
  --       Snacks.picker.grep({ hidden = true })
  --     end,
  --     desc = 'Grep',
  --   },
  -- },
  -- config = function()
  --   require('snacks').setup({
  --     picker = {
  --       layout = {
  --         layout = {
  --           box = 'horizontal',
  --           width = 0.8,
  --           min_width = 120,
  --           height = 0.8,
  --           {
  --             box = 'vertical',
  --             border = 'rounded',
  --             title = '{source} {live}',
  --             title_pos = 'center',
  --             { win = 'input', height = 1, border = 'bottom' },
  --             { win = 'list', border = 'none' },
  --           },
  --           { win = 'preview', border = 'rounded', width = 0.5 },
  --         },
  --       },
  --     },
  --   })
  -- end,
}
