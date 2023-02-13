-- local actions = require("telescope.actions")
local trouble = require("trouble.providers.telescope")

require('telescope').setup({
  defaults = {
		mappings = {
			i = { ["<c-t>"] = trouble.open_with_trouble },
			n = { ["<c-t>"] = trouble.open_with_trouble },
		},
	},
	extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    },
  },
	pickers = {
		find_files = {
			no_ignore = true,
			hidden = true,
		}
	}
})

local telescope = require('telescope')

-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
telescope.load_extension('fzf')

-- github cli
-- see https://github.com/nvim-telescope/telescope-github.nvim
telescope.load_extension('gh')

-- dap
telescope.load_extension('dap')

-- TODO: move these to keymap
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "files in cwd" })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "grep in cwd"})
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "buffers" })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = "help" })
vim.keymap.set('n', '<leader>fo', builtin.oldfiles, { desc = "opened files" })
vim.keymap.set('n', '<leader>fq', builtin.quickfix, { desc= "quickfix list" })
vim.keymap.set('n', '<leader>fs', builtin.treesitter, { desc = "symbols from treesitter" })
vim.keymap.set('n', '<leader>ft', '<cmd>Telescope telescope-tabs list_tabs<cr>', { desc = "tabs" })
