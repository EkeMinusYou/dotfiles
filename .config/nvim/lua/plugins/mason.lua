return {
	'williamboman/mason.nvim',
	config = function()
		require('mason').setup({
			ensured_installed = {
				'bash-language-server',
				'dockerfile-language-server',
				'goimports',
				'gopls',
				'json-lsp',
				'lua-language-server',
				'luaformatter',
				'prettier',
				'tailwindcss-language-server',
				'terraform-ls',
				'typescript-language-server',
				'vim-language-server',
			},
			automatic_installation = true,
		})
	end,
}
