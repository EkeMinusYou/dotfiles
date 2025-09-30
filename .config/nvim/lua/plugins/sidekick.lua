return {
  'folke/sidekick.nvim',
  keys = {
    {
      '<tab>',
      function()
        if not require('sidekick').nes_jump_or_apply() then
          return '<Tab>'
        end
      end,
      expr = true,
      desc = 'Goto/Apply Next Edit Suggestion',
    },
    {
      '<c-.>',
      function()
        require('sidekick.cli').focus()
      end,
      desc = 'Sidekick Switch Focus',
      mode = { 'n', 'v' },
    },
    {
      '<leader>aa',
      function()
        require('sidekick.cli').toggle({ focus = true })
      end,
      desc = 'Sidekick Toggle CLI',
      mode = { 'n', 'v' },
    },
    {
      '<leader>ac',
      function()
        require('sidekick.cli').toggle({ name = 'claude', focus = true })
      end,
      desc = 'Sidekick Claude Toggle',
      mode = { 'n', 'v' },
    },
    {
      '<leader>ap',
      function()
        require('sidekick.cli').select_prompt()
      end,
      desc = 'Sidekick Ask Prompt',
      mode = { 'n', 'v' },
    },
  },
}
