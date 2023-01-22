return {
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
      { 'nvim-telescope/telescope-frecency.nvim', dependencies = { 'kkharji/sqlite.lua' } },
    },
    event = 'VeryLazy',
    keys = {
      { '<leader>ff', '<CMD>Telescope frecency workspace=CWD<CR>' },
      { '<leader>fg', '<CMD>Telescope live_grep<CR>' },
      { '<leader>fb', '<CMD>Telescope buffers<CR>' },
    },
    config = function()
      local telescope = require('telescope')
      telescope.setup({
        defaults = {
          file_ignore_patterns = { 'node_modules/', '.git/' },
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
        },
      })
      telescope.load_extension('fzf')
      telescope.load_extension('frecency')
    end,
  },
}
