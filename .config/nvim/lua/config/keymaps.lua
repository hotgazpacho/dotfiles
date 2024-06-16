-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("i", "jk", "<Esc>", { desc = "Return to normal mode" })

vim.keymap.set({ "n", "v" }, "<leader>cg", function()
  vim.lsp.buf.definition()
end, { desc = "Go to Definition" })
vim.keymap.set({ "n", "v" }, "<leader>cr", "<cmd>FzfLua lsp_references<cr>", { desc = "References" })
vim.keymap.set({ "n", "v" }, "<leader>ci", "<cmd>FzfLua lsp_incoming_calls<cr>", { desc = "Incoming Calls" })
vim.keymap.set({ "n", "v" }, "<leader>df", "<cmd>FzfLua dap_configurations<cr>", { desc = "Con(f)igurations" })
vim.keymap.set({ "n", "v" }, "<leader>dv", "<cmd>FzfLuan dap_variables<cr>", { desc = "Session (v)ariables" })
