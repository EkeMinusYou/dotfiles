require("lualine").setup({
  options = {
    globalstatus = true,
    disabled_filetypes = { 'NvimTree' },
  },
})
vim.opt.laststatus = 3