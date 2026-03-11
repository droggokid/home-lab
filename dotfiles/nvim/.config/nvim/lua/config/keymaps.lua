-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<C-z>", "u", { desc = "Undo" })
vim.keymap.set("i", "<C-z>", "<C-o>u", { desc = "Undo" })

vim.keymap.set("v", "<C-c>", '"+y', { desc = "Copy to clipboard" })
vim.keymap.set("i", "<C-c>", '<C-o>"+yy', { desc = "Copy line to clipboard" })
vim.keymap.set("n", "<C-v>", '"+p', { desc = "Paste from clipboard" })
vim.keymap.set("i", "<C-v>", '<C-r>+', { desc = "Paste from clipboard" })

vim.keymap.set({ "n", "i" }, "<C-s>", "<cmd>w<cr>", { desc = "Save file" })

vim.keymap.set("n", "<C-a>", function()
  vim.cmd("normal! ggVG")
end, { desc = "Select all" })
vim.keymap.set("i", "<C-a>", "<Esc>ggVG", { desc = "Select all" })
