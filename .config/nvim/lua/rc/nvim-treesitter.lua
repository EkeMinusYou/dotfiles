require 'nvim-treesitter.configs'.setup {
  ensure_installed = {
		"lua",
		"dockerfile",
		"javascript",
		"typescript",
		"json",
		"html",
		"kotlin",
		"python",
		"sql",
		"toml",
		"ruby",
		"rust",
		"php",
		"perl",
		"fish",
		"make",
		"vim",
		"markdown",
	},
  auto_install = true,

  highlight = {
    enable = true,
  },

  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = nil,
  },
}
