local function file_exists(path)
  local f = io.open(path, 'r')
  if f ~= nil then
    io.close(f)
    return true
  else
    return false
  end
end

local function ghq_list(opts)
  local pickers = require('telescope.pickers')
  local finders = require('telescope.finders')
  local conf = require('telescope.config').values
  local actions = require('telescope.actions')
  local actions_set = require('telescope.actions.set')
  local actions_state = require('telescope.actions.state')
  local from_entry = require('telescope.from_entry')
  local entry_display = require('telescope.pickers.entry_display')

  opts = opts or {}

  local ghq_root = vim.fn.trim(vim.fn.system('ghq root'))

  local displayer = entry_display.create({
    separator = ' ',
    items = {
      { width = 40 },
      { width = 20 },
      { remaining = true },
    },
  })

  local make_display = function(entry)
    local metadata = entry.value
    local vcs, owner, repo = metadata:gsub(ghq_root, ''):match('/(.+)/(.+)/(.+)$')
    return displayer({
      { repo, 'TelescopeResultsIdentifier' },
      { owner, 'TelescopeResultsNormal' },
      { vcs, 'TelescopeResultsComment' },
    })
  end

  opts.entry_maker = function(entry)
    return {
      value = entry,
      ordinal = entry,
      display = make_display,
      path = entry,
    }
  end

  pickers
    .new(opts, {
      prompt_title = 'ghq list',
      finder = finders.new_oneshot_job({ 'ghq', 'list', '--full-path' }, opts),
      previewer = conf.file_previewer(opts),
      sorter = conf.file_sorter(opts),
      attach_mappings = function(prompt_bufnr, map)
        map('i', '<c-f>', function()
          local entry = actions_state.get_selected_entry()
          local dir = from_entry.path(entry)
          require('telescope.builtin').find_files({ cwd = dir })
        end)
        map('i', '<c-g>', function()
          local entry = actions_state.get_selected_entry()
          local dir = from_entry.path(entry)
          require('telescope').extensions.egrepify.egrepify({ cwd = dir })
        end)
        ---@diagnostic disable-next-line: undefined-field
        actions_set.select:replace(function(_, _)
          local entry = actions_state.get_selected_entry()
          local dir = from_entry.path(entry)

          local readme = dir .. '/' .. 'README.md'
          if file_exists(readme) then
            actions.close(prompt_bufnr)
            vim.api.nvim_command('edit ' .. readme)
          else
            require('telescope.builtin').find_files({ cwd = dir })
          end
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
