return {
	'akinsho/toggleterm.nvim',
	keys = {
		{
			"<leader>g",
			"<CMD>lua require('toggleterm.terminal').Terminal:new({cmd = 'lazygit', hidden = true, direction = 'float'}):toggle()<CR>"
		},
		{
			"<leader>k",
			"<CMD>lua require('toggleterm.terminal').Terminal:new({cmd = 'k9s --readonly', hidden = true, direction = 'float'}):toggle()<CR>"
		}
	},
	config = function()
		require("toggleterm").setup()
	end
}
