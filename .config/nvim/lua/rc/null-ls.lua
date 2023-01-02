local null_ls = require('null-ls')
null_ls.setup {
	sources = {
		null_ls.builtins.formatting.eslint,
		null_ls.builtins.diagnostics.eslint,
		null_ls.builtins.formatting.prettier,
		null_ls.builtins.formatting.gofmt,
		null_ls.builtins.diagnostics.staticcheck,
		null_ls.builtins.formatting.lua_format.with {
			extra_args = {
				"indent_width", "2",
				"use_tab", "false",
				"continuation_indent_width", "2",
				"keep_simple_block_one_line", "true",
				"keep_simple_function_one_line", "true",
				"align_parameter", "true",
			},
		},
	},
}
