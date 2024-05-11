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

return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    { 'nvim-lua/plenary.nvim' },
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    { 'fdschmidt93/telescope-egrepify.nvim' },
    { 'nvim-telescope/telescope-frecency.nvim' },
    { 'stevearc/aerial.nvim' },
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
    -- { ':', '<cmd>Telescope cmdline<cr>' },
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
  end,
}
