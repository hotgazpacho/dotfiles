-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local Util = require("lazyvim.util")
local wk = require("which-key")

vim.keymap.set("n", "<leader>cg", function()
  vim.lsp.buf.definition()
end, { desc = "Go to Definition" })
vim.keymap.set("n", "<leader>ch", function()
  vim.lsp.buf.hover()
end, { desc = "Hover information" })

if Util.has("toggleterm.nvim") then
  wk.register({
    ["<leader>t"] = { name = "+terminal" },
  })
  vim.keymap.set("n", "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", { desc = "ToggleTerm float" })
  vim.keymap.set(
    "n",
    "<leader>th",
    "<cmd>ToggleTerm size=10 direction=horizontal<cr>",
    { desc = "ToggleTerm horizontal split" }
  )
  vim.keymap.set(
    "n",
    "<leader>tv",
    "<cmd>ToggleTerm size=80 direction=vertical<cr>",
    { desc = "ToggleTerm vertical split" }
  )
  vim.keymap.set("n", "<leader>ta", "<cmd>ToggleTermToggleAll<cr>", { desc = "ToggleTerm all at once" })
  vim.keymap.set("n", "<leader>t<tab>", "<cmd>ToggleTerm direction=tab<cr>", { desc = "ToggleTerm tab" })
  vim.keymap.set("n", "<leader>tn", "<cmd>ToggleTermSetName<cr>", { desc = "Set Terminal Name" })
end
