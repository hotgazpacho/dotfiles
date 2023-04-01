-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local Util = require("lazyvim.util")
local wk = require("which-key")

vim.keymap.set({ "n", "v" }, "<leader>cg", function()
  vim.lsp.buf.definition()
end, { desc = "Go to Definition" })
vim.keymap.set({ "n", "v" }, "<leader>cr", "<cmd>Telescope lsp_references<cr>", { desc = "References" })
vim.keymap.set({ "n", "v" }, "<leader>ci", "<cmd>Telescope lsp_incoming_calls<cr>", { desc = "Incoming Calls" })
vim.keymap.set({ "", "v" }, "<leader>ch", function()
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

-- Git keymaps
if Util.has("gitlinker.nvim") then
  vim.keymap.set(
    "n",
    "<leader>gy",
    '<cmd>lua require"gitlinker".get_buf_range_url("n")<cr>',
    { desc = "Copy git link", silent = true }
  )
  vim.keymap.set(
    "v",
    "<leader>gy",
    '<cmd>lua require"gitlinker".get_buf_range_url("v")<cr>',
    { desc = "Copy git link" }
  )
  vim.keymap.set(
    "n",
    "<leader>gb",
    '<cmd>lua require"gitlinker".get_buf_range_url("n", {action_callback = require"gitlinker.actions".open_in_browser})<cr>',
    { desc = "Open git link in browser", silent = true }
  )
  vim.keymap.set(
    "v",
    "<leader>gb",
    '<cmd>lua require"gitlinker".get_buf_range_url("v", {action_callback = require"gitlinker.actions".open_in_browser})<cr>',
    { desc = "Open git link in browser" }
  )
end

-- Keymaps for Octo
if Util.has("octo.nvim") then
  wk.register({
    ["<leader>gh"] = { name = "+github" },
    ["<leader>ghp"] = { name = "+pr" },
  })
  vim.keymap.set({ "n", "v" }, "<leader>ghs", "<cmd>Octo search<cr>", { desc = "Search Issues and PRs" })
  vim.keymap.set({ "n", "v" }, "<leader>ghps", "<cmd>Octo pr search<cr>", { desc = "Search Pull Requests" })
end
