-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local Util = require("lazyvim.util")
local wk = require("which-key")

vim.keymap.set("i", "jk", "<Esc>", { desc = "Return to normal mode" })

vim.keymap.set({ "n", "v" }, "<leader>cg", function()
  vim.lsp.buf.definition()
end, { desc = "Go to Definition" })
vim.keymap.set({ "n", "v" }, "<leader>cr", "<cmd>Telescope lsp_references<cr>", { desc = "References" })
vim.keymap.set({ "n", "v" }, "<leader>ci", "<cmd>Telescope lsp_incoming_calls<cr>", { desc = "Incoming Calls" })

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
    ["<leader>gb"] = { name = "+github" },
    ["<leader>gbp"] = { name = "+pullrequest" },
  })
  vim.keymap.set("n", "<leader>gbs", "<cmd>Octo search<cr>", { desc = "Search" })
  vim.keymap.set("n", "<leader>gbb", "<cmd>Octo repo browser<cr>", { desc = "open in Browser" })
  vim.keymap.set("n", "<leader>gbpc", "<cmd>Octo pr checks<cr>", { desc = "Checks status" })
  vim.keymap.set("n", "<leader>gbps", "<cmd>Octo pr search<cr>", { desc = "Search" })
  vim.keymap.set("n", "<leader>gbpr", "<cmd>Octo pr ready<cr>", { desc = "Mark draft Ready for Review" })
  vim.keymap.set("n", "<leader>gbpv", "<cmd>Octo pr browser<cr>", { desc = "View in browser" })
  vim.keymap.set("n", "<leader>gbpu", "<cmd>Octo pr url<cr>", { desc = "copy URL" })
end

-- neoclip
vim.keymap.set("n", "<leader>sy", "<cmd>Telescope neoclip unnamed<cr>", { desc = "Clipboard (default register)" })
vim.keymap.set("n", '<leader>s"', "<cmd>Telescope neoclip unnamed<cr>", { desc = 'Clipboard (" register)' })
vim.keymap.set("n", "<leader>s*", "<cmd>Telescope neoclip star<cr>", { desc = "Clipboard (* register)" })
vim.keymap.set("n", "<leader>s+", "<cmd>Telescope neoclip plus<cr>", { desc = "Clipboard (+ register)" })
