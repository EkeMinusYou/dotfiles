require('telescope').setup({
	defaults = {
		file_ignore_patterns = {
			"node_modules",
			".git",
		}
	},
	pickers = {
		find_files = {
			hidden = true,
		},
		live_grep = {
			additional_args = function()
				return { "--hidden" }
			end
		},
	},
	extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    }
  }
})

require('telescope').load_extension('fzf')
