-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Go
-- Run gofmt + goimport on save
local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    require("go.format").goimport()
  end,
  group = format_sync_grp,
})

-- Terminal keymaps
vim.api.nvim_create_autocmd({ "TermOpen" }, {
  pattern = "term://*toggleterm#*",
  callback = function()
    vim.keymap.set("t", "<C-t>", "<Cmd>exe v:count1 . 'ToggleTerm'<CR>", { silent = true })
  end,
})
vim.api.nvim_create_autocmd({ "TermOpen" }, {
  pattern = "term://*",
  callback = function()
    local opts = { buffer = 0 }
    vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
    vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
    vim.keymap.set("t", "<A-h>", [[<Cmd>wincmd h<CR>]], opts)
    vim.keymap.set("t", "<A-j>", [[<Cmd>wincmd j<CR>]], opts)
    vim.keymap.set("t", "<A-k>", [[<Cmd>wincmd k<CR>]], opts)
    vim.keymap.set("t", "<A-l>", [[<Cmd>wincmd l<CR>]], opts)
    vim.keymap.set("t", "<A-w>", [[<C-\><C-n><C-w>]], opts)
  end,
})
