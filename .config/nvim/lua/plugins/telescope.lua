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

local function git_pickers(opts)
  local pickers = require('telescope.pickers')
  local finders = require('telescope.finders')
  local conf = require('telescope.config').values
  local actions_set = require('telescope.actions.set')
  local actions_state = require('telescope.actions.state')
  local from_entry = require('telescope.from_entry')

  opts = opts or {}

  pickers
    .new(opts, {
      prompt_title = 'git pickers',
      finder = finders.new_table({
        results = {
          'git_files',
          'git_stash',
          'git_status',
          'git_commits',
          'git_branches',
          'git_bcommits',
          'git_bcommits_range',
        },
      }),
      sorter = conf.generic_sorter(opts),
      attach_mappings = function(prompt_bufnr)
        actions_set.select:replace(function(_, type)
          local entry = actions_state.get_selected_entry()
          local picker = from_entry.path(entry)
          require('telescope.builtin')[picker]()
        end)
        return true
      end,
    })
    :find()
end

return {
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
      { 'fdschmidt93/telescope-egrepify.nvim' },
      { 'stevearc/aerial.nvim' },
      { 'nvim-telescope/telescope-ui-select.nvim' },
      { 'jonarrien/telescope-cmdline.nvim' }, -- experimental
      { dir = '~/.config/nvim/lua/internal/telescope-ghq.nvim' },
      { 'rcarriga/nvim-notify' },
      { 'prochri/telescope-all-recent.nvim' },
    },
    lazy = true,
    cmd = {
      'Telescope',
    },
    keys = {
      { '<leader>ff', '<cmd>Telescope find_files<cr>' },
      {
        '<leader>fg',
        function()
          require('telescope').extensions.egrepify.egrepify()
        end,
      },
      { '<leader>fk', grep_by_kensaku },
      { '<leader>fb', '<cmd>Telescope buffers<cr>' },
      { '<leader>v', git_pickers },
      { '<leader>fo', '<cmd>Telescope aerial<cr>' },
      -- { ':', '<cmd>Telescope cmdline<cr>' }, -- experimental
      { '<leader>fm', '<cmd>Telescope ghq list<cr>' },
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
      telescope.load_extension('cmdline')
      telescope.load_extension('aerial')
      telescope.load_extension('ui-select')
      telescope.load_extension('notify')
      -- local
      telescope.load_extension('ghq')
    end,
  },
  {
    'prochri/telescope-all-recent.nvim',
    lazy = true,
    dependencies = {
      'nvim-telescope/telescope.nvim',
      'kkharji/sqlite.lua',
      'stevearc/dressing.nvim',
    },
    config = function()
      require('telescope-all-recent').setup({
        pickers = {
          ['ghq#list'] = {
            disable = false,
            use_cwd = false,
            sorting = 'recent',
          },
        },
      })
    end,
  },
}
