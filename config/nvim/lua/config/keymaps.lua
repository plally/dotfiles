vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("n", "<leader>th", "<cmd>bp<CR>")
vim.keymap.set("n", "<leader>tl", "<cmd>bn<CR>")

vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
