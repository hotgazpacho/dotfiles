local solarized = require('solarized')

solarized.setup({
	transparent = false,
	theme = 'vim',
	mode = 'dark',
})

vim.opt.termguicolors = true
vim.cmd('colorscheme solarized')
