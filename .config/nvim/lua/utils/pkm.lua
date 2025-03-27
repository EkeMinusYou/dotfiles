local pkm = {}

local notes_dir = vim.fn.expand('~/PKM/journals')

pkm.open_daily_note = function(offset_days)
  local target_time = os.time() + (offset_days * 24 * 60 * 60)
  local filename = os.date('%Y-%m-%d.md', target_time)
  local file_path = vim.fs.joinpath(notes_dir, filename)
  vim.api.nvim_command('edit ' .. vim.fn.fnameescape(file_path))
end

pkm.daily_notes_actions = {
  Today = {
    function()
      pkm.open_daily_note(0)
    end,
    description = "Open today's daily note in specific directory",
  },
  Tomorrow = {
    function()
      pkm.open_daily_note(1)
    end,
    description = "Open tomorrow's daily note in specific directory",
  },
  Yesterday = {
    function()
      pkm.open_daily_note(-1)
    end,
    description = "Open yesterday's daily note in specific directory",
  },
}

return pkm
