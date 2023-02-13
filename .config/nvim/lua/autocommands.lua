-- Autocommand that reloads neovim whenever you save the plugins.lua file

vim.cmd([[
	augroup packer_user_config
		autocmd!
		autocmd BufWritePost plugins.lua source <afile> | PackerSync
	augroup end
]])
