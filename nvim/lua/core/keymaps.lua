vim.g.mapleader = " "

local map = vim.keymap.set
map("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle file tree" })
map("n", "<leader>ff", ":Telescope find_files<CR>", { desc = "Find files" })
map("n", "<leader>fg", ":Telescope live_grep<CR>", { desc = "Grep files" })
map("n", "<leader>fb", ":Telescope buffers<CR>", { desc = "List buffers" })
map("n", "<leader>fh", ":Telescope help_tags<CR>", { desc = "Help tags" })
map("n", "<leader>v", ":vsplit<CR>", { desc = "Vertical Split" })
map("n", "<leader>h", ":split<CR>", { desc = "Horizontal Split" })
map("n", "<C-t>", ":tabnew<CR>", { desc = "New Tab" })
map("n", "<C-s>", ":w<CR>", { desc = "Save" })
map("n", "<C-w>", ":wq<CR>", { desc = "Close Tab" })
-- TODO: is this the correct way to do new tabs?

-- Enable mouse in all modes
vim.opt.mouse = "a"

-- Move cursor with scroll wheel
vim.api.nvim_set_keymap("n", "<ScrollWheelUp>", "7k", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<ScrollWheelDown>", "7j", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<ScrollWheelUp>", "<Up>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<ScrollWheelDown>", "<Down>", { noremap = true, silent = true })
vim.api.nvim_set_keymap(
  "n",
  "<leader>gc",
  "<cmd>lua require('telescope.builtin').git_commits()<CR>",
  { noremap = true, silent = true }
)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
