local null_ls = require('null-ls')
null_ls.setup {
	sources = {
		null_ls.builtins.formatting.eslint,
		null_ls.builtins.diagnostics.eslint,
		null_ls.builtins.formatting.prettier,
		null_ls.builtins.formatting.gofmt,
		null_ls.builtins.diagnostics.staticcheck,
		null_ls.builtins.formatting.lua_format,
	},
}
