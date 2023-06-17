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

-- TypeScript/JavaScript
local ts_grp = vim.api.nvim_create_augroup("TSAutocmds", {})
-- EsLintAutoFix on save
--vim.api.nvim_create_autocmd("BufWritePre", {
-- pattern = { "*.ts", "*.tsx", "*.js", "*.jsx" },
--  command = "silent! EslintFixAll",
--  group = ts_grp,
--})
-- LspRestart eslint on saving package.json
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = { "package.json" },
  command = "LspRestart eslint",
  group = ts_grp,
})
