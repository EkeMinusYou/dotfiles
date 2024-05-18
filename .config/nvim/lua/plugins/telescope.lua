local function grep_by_kensaku()
  require('telescope').extensions.egrepify.egrepify({
    on_input_filter_cb = function(prompt)
      return {
        prompt = vim.fn['kensaku#query'](prompt, {
          rxop = vim.g['kensaku#rxop#javascript'],
        }),
      }
    end,
  })
end

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

return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    { 'nvim-lua/plenary.nvim' },
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    { 'fdschmidt93/telescope-egrepify.nvim' },
    { 'nvim-telescope/telescope-frecency.nvim' },
    { 'stevearc/aerial.nvim' },
    { 'nvim-telescope/telescope-ui-select.nvim' },
    { 'jonarrien/telescope-cmdline.nvim' }, -- experimental
  },
  event = 'VeryLazy',
  cmd = {
    'Telescope',
  },
  keys = {
    { '<leader>ff', '<cmd>Telescope find_files<cr>' },
    { '<leader>fr', '<cmd>Telescope frecency workspace=CWD<cr>' },
    {
      '<leader>fg',
      function()
        require('telescope').extensions.egrepify.egrepify()
      end,
    },
    { '<leader>fk', grep_by_kensaku },
    { '<leader>fb', '<cmd>Telescope buffers<cr>' },
    { '<leader>fs', '<cmd>Telescope git_status<cr>' },
    { '<leader>fo', '<cmd>Telescope aerial<cr>' },
    -- { ':', '<cmd>Telescope cmdline<cr>' }, -- experimental
    {
      '<leader>fm',
      function()
        ghq_list()
      end,
    },
  },
  config = function()
    local telescope = require('telescope')
    telescope.setup({
      defaults = {
        path_display = {
          'filename_first',
        },
        file_ignore_patterns = {
          'node_modules/',
          '.git/',
          '%.pb.go',
          '%.gen.go',
          '%.gw.go',
        },
        sorting_strategy = 'ascending',
        layout_strategy = 'horizontal',
        layout_config = { prompt_position = 'top' },
        border = true,
      },
      pickers = {
        find_files = { hidden = true },
        live_grep = {
          hidden = true,
        },
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = 'smart_case',
        },
        frecency = {
          db_safe_mode = false,
        },
        egrepify = {
          vimgrep_arguments = {
            {
              'rg',
              '--color=never',
              '--no-heading',
              '--with-filename',
              '--line-number',
              '--column',
              '--smart-case',
              '--hidden',
            },
          },
        },
        cmdline = {
          mappings = {
            complete = '<tab>',
            run_selection = '<cr>',
            run_input = '<c-cr>',
          },
        },
      },
    })

    telescope.load_extension('fzf')
    telescope.load_extension('egrepify')
    telescope.load_extension('frecency')
    telescope.load_extension('cmdline')
    telescope.load_extension('aerial')
    telescope.load_extension('ui-select')
  end,
}
