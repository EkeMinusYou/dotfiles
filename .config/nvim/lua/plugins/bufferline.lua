return {
	'akinsho/bufferline.nvim',
	dependencies = { 'nvim-tree/nvim-web-devicons' },
	event = 'VeryLazy',
	version = 'v3.x',
	config = { options = { offsets = { { filetype = 'NvimTree', text = 'Explorer', highlight = 'PanelHeading', padding = 1 } } } },
}
