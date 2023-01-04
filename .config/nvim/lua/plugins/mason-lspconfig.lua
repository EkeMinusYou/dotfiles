return {
	'williamboman/mason-lspconfig.nvim',
	dependencies = { 'neovim/nvim-lspconfig', 'williamboman/mason.nvim' },
	config = function()
		require("mason-lspconfig").setup_handlers {
			function(server_name)
				require("lspconfig")[server_name].setup {}
			end,
			["sumneko_lua"] = function()
				require('lspconfig').sumneko_lua.setup { settings = { Lua = { diagnostics = { globals = { 'vim' } } } } }
			end
		}
	end
}
