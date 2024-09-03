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

local function get_all_pickers(opts)
  local pickers = require('telescope.pickers')
  local finders = require('telescope.finders')
  local conf = require('telescope.config').values
  local actions_set = require('telescope.actions.set')
  local actions_state = require('telescope.actions.state')
  local from_entry = require('telescope.from_entry')
  local builtin_pickers = require('telescope.builtin')
  local extensions_pickers = require('telescope._extensions')

  opts = opts or {}

  local all_pickers = {}
  for k in pairs(builtin_pickers) do
    table.insert(all_pickers, k)
  end
  for k in pairs(extensions_pickers) do
    table.insert(all_pickers, k)
  end

  pickers
    .new(opts, {
      prompt_title = 'pickers',
      finder = finders.new_table({
        results = all_pickers,
      }),
      sorter = conf.generic_sorter(opts),
      attach_mappings = function(_)
        ---@diagnostic disable-next-line: undefined-field
        actions_set.select:replace(function(_, _)
          local entry = actions_state.get_selected_entry()
          local picker = from_entry.path(entry)
          if builtin_pickers[picker] then
            builtin_pickers[picker]()
          else
            extensions_pickers[picker]()
          end
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
      { 'fdschmidt93/telescope-egrepify.nvim', dependencies = { 'nvim-treesitter/nvim-treesitter' } },
      { 'stevearc/aerial.nvim' },
      { 'nvim-telescope/telescope-ui-select.nvim' },
      { 'jonarrien/telescope-cmdline.nvim' }, -- experimental
      { dir = '~/.config/nvim/lua/internal/telescope-ghq.nvim' },
      { 'rcarriga/nvim-notify' },
      { 'prochri/telescope-all-recent.nvim' },
      { 'ThePrimeagen/refactoring.nvim' },
    },
    lazy = true,
    cmd = {
      'Telescope',
    },
    -- wrap because telescope-all-recent.nvim
    -- See: https://github.com/prochri/telescope-all-recent.nvim/issues/2
    keys = {
      {
        '<leader>ff',
        function()
          require('telescope.builtin').find_files()
        end,
      },
      {
        '<leader>fg',
        function()
          require('telescope').extensions.egrepify.egrepify()
        end,
      },
      { '<leader>fk', grep_by_kensaku },
      {
        '<leader>fb',
        function()
          require('telescope.builtin').buffers()
        end,
      },
      { '<leader>fa', get_all_pickers },
      {
        '<leader>fo',
        function()
          require('telescope').extensions.aerial.aerial()
        end,
      },
      { '<leader>fh', '<cmd>Telescope help_tags<cr>' },
      {
        '<leader>fh',
        function()
          require('telescope.builtin').help_tags()
        end,
      },
      -- { ':', '<cmd>Telescope cmdline<cr>' }, -- experimental
      {
        '<leader>p',
        function()
          require('telescope').extensions.ghq.list()
        end,
      },
      {
        '<leader>vb',
        function()
          require('telescope.builtin').git_branches()
        end,
      },
      {
        '<leader>vc',
        function()
          require('telescope.builtin').git_commits()
        end,
      },
      {
        '<leader>vs',
        function()
          require('telescope.builtin').git_status()
        end,
      },
    },
    config = function()
      local telescope = require('telescope')
      local actions = require('telescope.actions')
      telescope.setup({
        defaults = {
          mappings = {
            i = {
              ['<C-j>'] = actions.cycle_history_next,
              ['<C-k>'] = actions.cycle_history_prev,
            },
          },
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
            results_ts_hl = true,
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
      telescope.load_extension('refactoring')
      -- local
      telescope.load_extension('ghq')

      ---@diagnostic disable-next-line: missing-fields
      require('telescope-all-recent').setup({
        pickers = {
          ['ghq#list'] = {
            ---@diagnostic disable-next-line: assign-type-mismatch
            disable = false,
            ---@diagnostic disable-next-line: assign-type-mismatch
            use_cwd = false,
            sorting = 'frecency',
          },
        },
      })
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
  },
}
