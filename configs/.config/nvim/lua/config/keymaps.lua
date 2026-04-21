-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- restore original indent behavior
pcall(vim.keymap.del, "x", "<")
pcall(vim.keymap.del, "x", ">")

-- fix Y behavior to behave like D and C
vim.keymap.set("n", "Y", "y$")

-- make search results be centered
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("n", "<leader>fs", "<cmd>w<cr>", { desc = "Save file" })
vim.keymap.set("n", "<leader>fS", "<cmd>wa<cr>", { desc = "Save all files" })
