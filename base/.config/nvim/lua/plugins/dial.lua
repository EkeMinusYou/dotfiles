return {
  'monaqa/dial.nvim',
  event = 'BufReadPost',
  config = function()
    local augend = require('dial.augend')
    require('dial.config').augends:register_group({
      default = {
        -- default
        augend.integer.alias.decimal,
        augend.integer.alias.hex,
        augend.date.alias['%Y/%m/%d'],
        augend.date.alias['%Y-%m-%d'],
        augend.date.alias['%m/%d'],
        augend.date.alias['%H:%M'],
        augend.constant.alias.ja_weekday_full,

        -- custom
        augend.constant.alias.bool,
        augend.semver.alias.semver,
        augend.constant.new({
          elements = { 'and', 'or' },
          word = true,
          cyclic = true,
        }),
        augend.constant.new({
          elements = { '&&', '||' },
          word = true,
          cyclic = true,
        }),
        augend.case.new({
          types = { 'camelCase', 'snake_case' },
          word = true,
          cyclic = true,
        }),
      },
    })

    vim.keymap.set('n', '<C-a>', function()
      require('dial.map').manipulate('increment', 'normal')
    end)
    vim.keymap.set('n', '<C-x>', function()
      require('dial.map').manipulate('decrement', 'normal')
    end)
    vim.keymap.set('n', 'g<C-a>', function()
      require('dial.map').manipulate('increment', 'gnormal')
    end)
    vim.keymap.set('n', 'g<C-x>', function()
      require('dial.map').manipulate('decrement', 'gnormal')
    end)
    vim.keymap.set('v', '<C-a>', function()
      require('dial.map').manipulate('increment', 'visual')
    end)
    vim.keymap.set('v', '<C-x>', function()
      require('dial.map').manipulate('decrement', 'visual')
    end)
    vim.keymap.set('v', 'g<C-a>', function()
      require('dial.map').manipulate('increment', 'gvisual')
    end)
    vim.keymap.set('v', 'g<C-x>', function()
      require('dial.map').manipulate('decrement', 'gvisual')
    end)
  end,
}
