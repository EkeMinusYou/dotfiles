return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    { 'nvim-lua/plenary.nvim' },
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    { 'nvim-telescope/telescope-live-grep-args.nvim' },
    { 'nvim-telescope/telescope-frecency.nvim' },
    { 'jonarrien/telescope-cmdline.nvim' }, -- experimental
  },
  event = 'VeryLazy',
  keys = {
    { '<leader>ff', '<cmd>Telescope find_files<cr>' },
    { '<leader>fr', '<cmd>Telescope frecency workspace=CWD<cr>' },
    { '<leader>fg', "<cmd>:lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>" },
    { '<leader>fb', '<cmd>Telescope buffers<cr>' },
    { '<leader>fs', '<cmd>Telescope git_status<cr>' },
  },
  config = function()
    local telescope = require('telescope')
    local lga_actions = require('telescope-live-grep-args.actions')
    telescope.setup({
      defaults = {
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
          additional_args = function()
            return { '--hidden' }
          end,
        },
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = 'smart_case',
        },
        live_grep_args = {
          auto_quoting = true,
          mappings = {
            i = {
              ['<C-k>'] = lga_actions.quote_prompt(),
              ['<C-i>'] = lga_actions.quote_prompt({ postfix = ' --iglob ' }),
            },
          },
          vimgrep_arguments = {
            {
              'rg',
              '--hidden',
              '--color=never',
              '--no-heading',
              '--with-filename',
              '--line-number',
              '--column',
              '--smart-case',
            },
          },
        },
      },
    })

    telescope.load_extension('fzf')
    telescope.load_extension('live_grep_args')
    telescope.load_extension('frecency')
    telescope.load_extension('cmdline')
  end,
}
