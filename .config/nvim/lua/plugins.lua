local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

	-- Theme
	use 'maxmx03/solarized.nvim'

	-- treesitter
	use {
		'nvim-treesitter/nvim-treesitter',
		run = function()
			local ts_update = require('nvim-treesitter.install').update({
				with_sync = true,
			})
			ts_update()
		end,
	}

	-- Telescope file finder
	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.1',
		requires = {
			{ 'nvim-lua/plenary.nvim' },
			{ 'nvim-telescope/telescope-github.nvim' },
			{ 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
		}
	}

	use {
		'LukasPietzschmann/telescope-tabs',
		requires = { 'nvim-telescope/telescope.nvim' },
		config = function()
			require'telescope-tabs'.setup()
		end
	}

	-- File Explorer
	use {
		"nvim-tree/nvim-tree.lua",
		requires = {
			{ "nvim-tree/nvim-web-devicons" }
		}
	}

	-- Which Key help popup
	use {
		"folke/which-key.nvim",
		config = function()
			require("config.whichkey").setup()
		end,
	}

	-- LSP
  use {
		'VonHeikemen/lsp-zero.nvim',
			branch = 'v1.x',
			requires = {
				-- LSP Support
				{'neovim/nvim-lspconfig'},
				{'williamboman/mason.nvim'},
				{'williamboman/mason-lspconfig.nvim'},

				-- Autocompletion
				{'hrsh7th/nvim-cmp'},
				{'hrsh7th/cmp-buffer'},
				{'hrsh7th/cmp-path'},
				{'saadparwaiz1/cmp_luasnip'},
				{'hrsh7th/cmp-nvim-lsp'},
				{'hrsh7th/cmp-nvim-lua'},

				-- Snippets
				{'L3MON4D3/LuaSnip'},
				{'rafamadriz/friendly-snippets'},
		}
	}

	-- LSP Signature
	use {
		"ray-x/lsp_signature.nvim",
		event = "BufRead",
		config = function() require"lsp_signature".on_attach() end,
	}

	-- null-ls linting/formatting/diagnostics
	use {
		"jose-elias-alvarez/null-ls.nvim",
	}

	-- Refactoring
	use {
    "ThePrimeagen/refactoring.nvim",
    requires = {
        {"nvim-lua/plenary.nvim"},
        {"nvim-treesitter/nvim-treesitter"}
    },
		config = function()
			require("config.refactor").setup()
		end,
	}

	-- Code Action Menu
	use {
		"weilbith/nvim-code-action-menu",
		cmd = "CodeActionMenu",
	}

	-- Show a lightbulb when a code action is available
	use {
		"kosayoda/nvim-lightbulb",
		requires = "antoinemadec/FixCursorHold.nvim",
	}

	-- Adds any missing LSP diagnostic highlight groups
	use "folke/lsp-colors.nvim"

	-- Diagnostics list
	use {
		"folke/trouble.nvim",
		requires = "nvim-tree/nvim-web-devicons",
		config = function()
			require("config.trouble").setup()
		end,
	}

	-- Debugging
	use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"} }
	use { 'mfussenegger/nvim-dap' }
	use {
		'leoluz/nvim-dap-go',
		config = function()
			require("config.dap.go").setup()
		end,
	}
	use {
		"microsoft/vscode-js-debug",
		opt = true,
		run = "npm install --legacy-peer-deps && npm run compile",
		config = function()
			require("config.dap.javascript").setup()
		end,
	}
	use {
		"nvim-telescope/telescope-dap.nvim",
		requires = "nvim-lua/popup.nvim",
	}
	use {
		"theHamsta/nvim-dap-virtual-text",
	}

	-- Lualine information/status bar
	use {
		"nvim-lualine/lualine.nvim",
		requires = {
			{ "kyazdani42/nvim-web-devicons", opt = true }
		}
	}

	-- Toggle Terminal
	use {
		"akinsho/toggleterm.nvim",
		tag = '*',
		config = function()
			require("config.terminal").setup()
		end,
	}

	-- gitsigns
	use {
		'lewis6991/gitsigns.nvim',
		tag = 'release' -- To use the latest release (do not use this if you run Neovim nightly or dev builds!)
	}

	-- diffview
	use {
		'sindrets/diffview.nvim',
		requires = 'nvim-lua/plenary.nvim'
	}

	-- git-blame
	use {
		"f-person/git-blame.nvim",
		event = "BufRead",
		config = function()
			vim.cmd "highlight default link gitblame SpecialComment"
			vim.g.gitblame_enabled = 0
		end,
	}

	-- git-linker
	use {
		"ruifm/gitlinker.nvim",
		event = "BufRead",
		config = function()
			require("gitlinker").setup({
        opts = {
          -- remote = 'github', -- force the use of a specific remote
          -- adds current line nr in the url for normal mode
          add_current_line_on_normal_mode = true,
          -- callback for what to do with the url
          action_callback = require("gitlinker.actions").open_in_browser,
          -- print the url after performing the action
          print_url = false,
          -- mapping to call url generation
          mappings = "<leader>gy",
        },
      })
		end,
		requires = "nvim-lua/plenary.nvim",
	}

	-- octo
	use {
		"pwntester/octo.nvim",
		requires = {
			'nvim-lua/plenary.nvim',
			'nvim-telescope/telescope.nvim',
			'kyazdani42/nvim-web-devicons',
		},
		config = function()
			require("octo").setup()
		end,
	}

	-- fugitive
	use {
		"tpope/vim-fugitive",
		cmd = {
			"G",
			"Git",
			"Gdiffsplit",
			"Gread",
			"Gwrite",
			"Ggrep",
			"GMove",
			"GDelete",
			"GBrowse",
			"GRemove",
			"GRename",
			"Glgrep",
			"Gedit"
		},
		ft = {"fugitive"}
	}

	-- Cheatsheet
	use {
		'sudormrfbin/cheatsheet.nvim',
		requires = {
			{'nvim-telescope/telescope.nvim'},
			{'nvim-lua/popup.nvim'},
			{'nvim-lua/plenary.nvim'},
		}
	}

	-- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
