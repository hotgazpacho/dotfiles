-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local opt = vim.opt

if vim.g.vscode then
  opt.cursorcolumn = false
  opt.cursorline = false
else
  opt.cursorcolumn = true -- Enable highlighting of the current column
end

opt.hlsearch = false -- Disable highlighting search results

vim.g.loaded_perl_provider = 0
