return {
	'nvim-lualine/lualine.nvim',
	dependencies = { 'nvim-tree/nvim-web-devicons' },
	config = function()
		require("lualine").setup({
			options = {
				globalstatus = true,
				disabled_filetypes = { 'NvimTree' },
				section_separators = "",
				component_separators = ""
			},
		})
	end
}
