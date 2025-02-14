vim.filetype.add({
  filename = {
    -- atlas
    ['atlas.hcl'] = 'atlas-config',
    -- Brew
    ['Brewfile'] = 'ruby',
    -- CocoaPods
    ['Podfile'] = 'ruby',
    -- Swift
    ['Package.resolved'] = 'json',
    ['.swift-format'] = 'json',
    -- deno
    ['deno.lock'] = 'json',
  },
  pattern = {
    -- git
    ['*/.gitconfig-*'] = 'gitconfig',
    -- env
    ['.env.*'] = 'sh',
    -- sql
    ['*.ddl'] = 'sql',
    -- atlas
    ['.*/*.my.hcl'] = 'atlas-schema-mysql',
    ['.*/*.pg.hcl'] = 'atlas-schema-postgresql',
    ['.*/*.lt.hcl'] = 'atlas-schema-sqlite',
    ['.*/*.ch.hcl'] = 'atlas-schema-clickhouse',
    ['.*/*.ms.hcl'] = 'atlas-schema-mssql',
    ['.*/*.rs.hcl'] = 'atlas-schema-redshift',
    ['.*/*.test.hcl'] = 'atlas-test',
    ['.*/*.plan.hcl'] = 'atlas-plan',
    -- CocoaPods
    ['.*/*.podspec'] = 'ruby',
    -- Swift
    ['*/*.xcstrings'] = 'json',
    ['*/*.swiftinterface'] = 'swift',
  },
})

-- See: https://github.com/ngalaiko/tree-sitter-go-template
vim.filetype.add({
  extension = {
    gotmpl = 'gotmpl',
  },
  pattern = {
    ['.*/templates/.*%.tpl'] = 'helm',
    ['.*/templates/.*%.ya?ml'] = 'helm',
    ['helmfile.*%.ya?ml'] = 'helm',
  },
})

vim.api.nvim_create_augroup('filetype', {})

-- swift
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile', 'LspAttach' }, {
  pattern = '*.swift',
  group = 'filetype',
  command = 'setlocal shiftwidth=2 tabstop=2 softtabstop=2 commentstring=//\\ %s',
})

-- terraform
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile', 'LspAttach' }, {
  pattern = '*.tf',
  group = 'filetype',
  command = 'setlocal shiftwidth=2 tabstop=2 commentstring=//\\ %s',
})

-- Makefile
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = {
    'makefile',
    'Makefile',
  },
  group = 'filetype',
  command = 'setlocal noexpandtab tabstop=4 shiftwidth=4',
})

-- yaml
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile', 'LspAttach' }, {
  pattern = {
    '*.yaml',
    '*.yml',
  },
  group = 'filetype',
  callback = function()
    vim.bo.expandtab = true
    vim.bo.tabstop = 2
    vim.bo.shiftwidth = 2
  end,
})
