local install = function(spec)
  local installedDir = spec.dir

  local currentDir = vim.fn.getcwd()
  vim.fn.chdir(installedDir)
  vim.fn.system('gh extension install .')
  vim.fn.chdir(currentDir)
end

return {
  { 'seachicken/gh-poi', build = { 'go build', install }, lazy = true },
}
