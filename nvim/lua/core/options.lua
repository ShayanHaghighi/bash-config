vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.termguicolors = true
vim.opt.mouse = "a"
vim.opt.list = true
vim.opt.listchars:append("space:⋅")
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*/starship/*.mustache",
  callback = function()
    vim.bo.filetype = "toml"
  end,
})
