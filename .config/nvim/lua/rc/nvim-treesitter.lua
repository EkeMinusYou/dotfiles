require 'nvim-treesitter.configs'.setup {
  ensure_installed = {
		"help",
		"lua",
		"dockerfile",
		"javascript",
		"typescript",
		"json",
		"go",
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
}
