local function ghq_list(opts)
  local pickers = require('telescope.pickers')
  local finders = require('telescope.finders')
  local conf = require('telescope.config').values
  local actions = require('telescope.actions')
  local actions_set = require('telescope.actions.set')
  local actions_state = require('telescope.actions.state')
  local from_entry = require('telescope.from_entry')

  opts = opts or {}

  local ghq_root = vim.fn.trim(vim.fn.system('ghq root'))

  opts.entry_maker = function(entry)
    return {
      value = entry,
      ordinal = entry,
      display = entry:gsub(ghq_root .. '/', ''),
      path = entry,
    }
  end

  pickers
    .new(opts, {
      prompt_title = 'ghq list',
      finder = finders.new_oneshot_job({ 'ghq', 'list', '--full-path' }, opts),
      previewer = conf.file_previewer(opts),
      sorter = conf.file_sorter(opts),
      attach_mappings = function(prompt_bufnr)
        ---@diagnostic disable-next-line: undefined-field
        actions_set.select:replace(function(_, type)
          local entry = actions_state.get_selected_entry()
          local dir = from_entry.path(entry)
          if type == 'default' then
            require('telescope.builtin').find_files({ cwd = dir })
            return
          end
          actions.close(prompt_bufnr)
        end)
        return true
      end,
    })
    :find()
end

return require('telescope').register_extension({
  exports = {
    list = ghq_list,
  },
})
