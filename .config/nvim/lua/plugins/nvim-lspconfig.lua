return {
	'neovim/nvim-lspconfig',
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
	},
	config = function()
		local lspconfig = require('lspconfig')
		lspconfig.sumneko_lua.setup {
			settings = {
				Lua = {
					diagnostics = {
						globals = { 'vim' },
					},
				},
			},
		}
	end
}
