vim.api.nvim_create_user_command('Today', "lua require('utils/pkm').open_daily_note(0)", {
  desc = "Open today's daily note in specific directory",
})
vim.api.nvim_create_user_command('Tomorrow', "lua require('utils/pkm').open_daily_note(1)", {
  desc = "Open tomorrow's daily note in specific directory",
})
vim.api.nvim_create_user_command('Yesterday', "lua require('utils/pkm').open_daily_note(-1)", {
  desc = "Open yesterday's daily note in specific directory",
})
