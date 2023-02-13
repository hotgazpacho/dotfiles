-- vim api aliases
local opt = vim.opt

-- Show line numbers
opt.number = true
opt.relativenumber = true

-- Allow using the mouse
opt.mouse = 'a'

-- Case-insensitive search
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true

-- Disable highlighting search results
opt.hlsearch = false

-- Line wrapping
opt.wrap = true
opt.breakindent = true

-- Tab & Indent
opt.tabstop = 2
opt.shiftwidth = 2

-- Do not convert tabs to spaces
opt.expandtab = false

-- Cursor
opt.cursorline = true
opt.cursorcolumn = true

-- scrolling
opt.scrolloff = 8
opt.signcolumn = "yes"

-- Split to the right
opt.splitright = true

-- command timeout
opt.timeout = true
opt.timeoutlen = 300

-- Undo magic
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
