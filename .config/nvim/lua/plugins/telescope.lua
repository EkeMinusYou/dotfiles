return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    { 'nvim-lua/plenary.nvim' },
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    { 'nvim-telescope/telescope-live-grep-args.nvim' },
    { 'nvim-telescope/telescope-file-browser.nvim' },
  },
  event = 'VeryLazy',
  keys = {
    { '<leader>ff', '<cmd>Telescope find_files<cr>' },
    { '<leader>fg', "<cmd>:lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>" },
    { '<leader>fb', '<cmd>Telescope buffers<cr>' },
    { '<leader>fs', '<cmd>Telescope git_status<cr>' },
    { '<leader>e', '<cmd>Telescope file_browser<cr>' },
  },
  config = function()
    local telescope = require('telescope')
    local lga_actions = require('telescope-live-grep-args.actions')
    local fb_actions = require('telescope._extensions.file_browser.actions')
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
        file_browser = {
          hidden = { file_browser = true, folder_browser = true },
          grouped = true,
          mappings = {
            ['i'] = {
              ['<A-c>'] = fb_actions.create,
              ['<S-CR>'] = fb_actions.create_from_prompt,
              ['<A-r>'] = fb_actions.rename,
              ['<A-m>'] = fb_actions.move,
              ['<A-y>'] = fb_actions.copy,
              ['<A-d>'] = fb_actions.remove,
              ['<C-o>'] = fb_actions.open,
              ['<C-g>'] = fb_actions.goto_parent_dir,
              ['<C-e>'] = fb_actions.goto_home_dir,
              ['<C-w>'] = fb_actions.goto_cwd,
              ['<C-t>'] = fb_actions.change_cwd,
              ['<C-f>'] = fb_actions.toggle_browser,
              ['<C-h>'] = fb_actions.toggle_hidden,
              ['<C-s>'] = fb_actions.toggle_all,
              ['<bs>'] = fb_actions.backspace,
            },
            ['n'] = {
              ['c'] = fb_actions.create,
              ['r'] = fb_actions.rename,
              ['m'] = fb_actions.move,
              ['y'] = fb_actions.copy,
              ['d'] = fb_actions.remove,
              ['o'] = fb_actions.open,
              ['g'] = fb_actions.goto_parent_dir,
              ['e'] = fb_actions.goto_home_dir,
              ['w'] = fb_actions.goto_cwd,
              ['t'] = fb_actions.change_cwd,
              ['f'] = fb_actions.toggle_browser,
              ['h'] = fb_actions.toggle_hidden,
              ['s'] = fb_actions.toggle_all,
            },
          },
        },
      },
    })

    telescope.load_extension('fzf')
    telescope.load_extension('live_grep_args')
    telescope.load_extension('file_browser')
  end,
}
