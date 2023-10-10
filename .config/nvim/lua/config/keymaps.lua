-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("i", "jk", "<Esc>", { desc = "Return to normal mode" })

vim.keymap.set({ "n", "v" }, "<leader>cg", function()
  vim.lsp.buf.definition()
end, { desc = "Go to Definition" })
vim.keymap.set({ "n", "v" }, "<leader>cr", "<cmd>Telescope lsp_references<cr>", { desc = "References" })
vim.keymap.set({ "n", "v" }, "<leader>ci", "<cmd>Telescope lsp_incoming_calls<cr>", { desc = "Incoming Calls" })
vim.keymap.set({ "n" }, "<leader>fN", "<cmd>Telescope notify<cr>", { desc = "Notifications" })
