require("lualine").setup({
  options = {
    globalstatus = true,
    disabled_filetypes = { 'NvimTree' },
    section_separators = "",
    component_separators = ""
  },
})
vim.opt.laststatus = 3
