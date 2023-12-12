local vscodeDir = vim.fn.stdpath('data') .. '/lazy/vscode'
local vscodeSnippets = {
  [vscodeDir .. '/extensions/typescript-basics/snippets'] = 'typescript.code-snippets',
  [vscodeDir .. '/extensions/javascript/snippets'] = 'javascript.code-snippets',
  [vscodeDir .. '/extensions/markdown-basics/snippets'] = 'markdown.code-snippets',
}

local function create_json_files()
  for dir, filename in pairs(vscodeSnippets) do
    local filePath = dir .. '/' .. filename
    local snippetFile = io.open(filePath, 'r')
    if snippetFile then
      local content = snippetFile:read('*a')
      snippetFile:close()

      local jsonPath = filePath:gsub('%.code%-snippets$', '.json')
      local jsonFile = io.open(jsonPath, 'w')
      if jsonFile then
        jsonFile:write(content)
        jsonFile:close()
      end
    end
  end
end

return {
  'hrsh7th/vim-vsnip',
  dependencies = {
    { 'golang/vscode-go' },
    { 'microsoft/vscode', build = { create_json_files() } },
  },
  config = function()
    local dirs = {}
    for dir in pairs(vscodeSnippets) do
      table.insert(dirs, dir)
    end
    vim.g.vsnip_snippet_dirs = dirs
  end,
  lazy = true,
}
