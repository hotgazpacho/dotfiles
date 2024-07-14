-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local opt = vim.opt

if vim.g.vscode then
  opt.cursorcolumn = false
  opt.cursorline = false
else
  opt.cursorcolumn = true -- Enable highlighting of the current column
  -- Rulers
  opt.ruler = true
  opt.colorcolumn = "100"

  -- Folding
  opt.foldmethod = "expr"
  opt.foldexpr = "nvim_treesitter#foldexpr()"
  opt.foldenable = false -- don't fild everything by default
  opt.foldcolumn = "auto:3"
  opt.foldminlines = 5
  opt.fillchars = opt.fillchars + "foldopen:󰛲,foldclose:󰜄"

  opt.exrc = true

  -- Title
  opt.title = true
  -- Tail of filename in the buffer
  -- (omit if empty: space, modified flag)
  -- (omit if empty: space, readonly flag)
  -- (omit if empty: space, relative path to file in buffer)
  opt.titlestring = [[%t%( %M%)%( %R%) (%f)]]
end

opt.hlsearch = false -- Disable highlighting search results

vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

-- python setup
vim.g.python3_host_prog = vim.fs.normalize("~/.pyenv/versions/neovim3/bin/python")
