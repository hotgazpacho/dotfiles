require('nvim-treesitter.configs').setup({
	-- A list of parser names, or "all"
	ensure_installed = {
		"bash",
		"comment",
		"css",
		"diff",
		"dockerfile",
		"git_rebase",
		"gitattributes",
		"gitcommit",
		"gitignore",
		"go",
		"gomod",
		"gowork",
		"graphql",
		"help",
		"html",
		"jq",
		"jsdoc",
		"json",
		"json5",
		"jsonc",
		"lua",
		"make",
		"markdown",
		"mermaid",
		"proto",
		"python",
		"regex",
		"ruby",
		"rust",
		"scss",
		"sql",
		"terraform",
		"todotxt",
		"toml",
		"tsx",
		"typescript",
		"yaml",
	},

	-- Install parsers synchronously
	sync_install = false,

	-- Automatically install parsers when entering buffer
	auto_install = true,

	hightlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
})
