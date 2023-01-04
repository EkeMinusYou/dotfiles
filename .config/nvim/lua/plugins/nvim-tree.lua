return {
	'nvim-tree/nvim-tree.lua',
	dependencies = { 'nvim-tree/nvim-web-devicons' },
	config = function()
		require("nvim-tree").setup({
			respect_buf_cwd = true,
			sync_root_with_cwd = true,
			update_focused_file = { enable = true, update_root = true },
			view = {
				width = 40,
				mappings = {
					list = {
						{ key = "l", action = "edit" },
						{ key = "h", action = "close_node" },
						{ key = "C", action = "cd" },
					},
				},
			},
		})
	end
}