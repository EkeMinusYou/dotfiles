return {
	'hrsh7th/nvim-cmp',
	event = { 'InsertEnter', 'CmdlineEnter' },
	dependencies = {
		{ 'hrsh7th/cmp-nvim-lsp', dependencies = { 'neovim/nvim-lspconfig' } },
		{ 'hrsh7th/cmp-buffer' },
		{ 'hrsh7th/cmp-path' },
		{ 'hrsh7th/cmp-cmdline' },
		{ 'hrsh7th/vim-vsnip' },
	},
	config = function()
		local cmp = require('cmp')
		cmp.setup {
			snippet = {
				expand = function(args)
					vim.fn['vsnip#anonymous'](args.body)
				end,
			},
			sources = { { name = 'nvim_lsp' }, { name = 'buffer' }, { name = 'path' }, { name = 'cmdline' } },
			mapping = cmp.mapping.preset.insert({
				['<C-p>'] = cmp.mapping.select_prev_item(),
				['<C-n>'] = cmp.mapping.select_next_item(),
				['<C-l>'] = cmp.mapping.complete(),
				['<C-e>'] = cmp.mapping.abort(),
				['<CR>'] = cmp.mapping.confirm { select = true },
				['<Tab>'] = cmp.mapping.confirm { select = true },
			}),
		}
	end,
}
