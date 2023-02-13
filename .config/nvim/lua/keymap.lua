-- update leader key to space
vim.g.mapleader = " "
vim.g.showcmd = true

local map = vim.api.nvim_set_keymap

-- Toggle the tree view with n
map('n', '<leader>e', [[:NvimTreeToggle<CR>]], { desc = "Explore" })

-- Code Action Menu
map('n', "<leader>.", '<cmd>CodeActionMenu<cr>', { desc = "Code actions" })

-- Trouble
map("n", "<leader>xx", "<cmd>TroubleToggle<cr>",
  {silent = true, noremap = true}
)
map("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>",
  {silent = true, noremap = true}
)
map("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>",
  {silent = true, noremap = true}
)
map("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>",
  {silent = true, noremap = true}
)
map("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>",
  {silent = true, noremap = true}
)
map("n", "gR", "<cmd>TroubleToggle lsp_references<cr>",
  {silent = true, noremap = true}
)

-- Terminal
map("n", "<leader>tf", "<cmd>ToggleTerm direction=float<CR>",
 {noremap = true, silent = true, desc = "floating terminal" }
)
map("n", "<leader>th", "<cmd>ToggleTerm direction=horizontal<CR>",
 {noremap = true, silent = true, desc = "horizontal terminal"}
)
map("n", "<leader>tv", "<cmd>ToggleTerm direction=vertical<CR>",
 {noremap = true, silent = true, desc = "vertical terminal"}
)
map("n", "<leader>tt", "<cmd>ToggleTerm direction=tab<CR>",
 {noremap = true, silent = true, desc = "tab terminal" }
)
map("n", "<leader>tl", "<cmd>lua _lazygit_toggle()<CR>",
	{noremap = true, silent = true, desc = "lazygit terminal"}
)

-- Debugging
map('n', '<leader>dd', [[:NvimTreeToggle<CR> <cmd>lua require'dapui'.toggle()<CR>]],
	{desc ="Debug", noremap=true, silent=true}
)
map('n', '<leader>di', "<cmd>lua require'dap.ui.widgets'.hover",
	{desc="Inspect", noremap=true, silent=true}
)
map('v', '<leader>di', "<cmd>lua require'dap.ui.variables'.visual_hover",
	{desc="Inspect", noremap=true, silent=true}
)
map('n', '<leader>d?', "<cmd>lua local widgets=require'dap.up.widgets';widgets.centered_float(widgets.scopes)<CR>",
	{desc="What's in scope?", noremap=true, silent=true}
)
map('n', '<leader>dr', "<cmd>lua require'dap'.repl.open({}, 'vsplit')<CR>",
	{desc="REPL", noremap=true, silent=true}
)
map('n', '<leader>de', "<cmd>lua require'dap'.set_exception_breakpoints({'all'})",
	{desc="Stop on Exceptions", noremap=true, silent=true}
)
map('n', '<leader>dk', "<cmd>lua require'dap.up()",
	{desc="Up the callstack", noremap=true, silent=true}
)
map('n', '<leader>dj', "<cmd>lua require'dap.down()",
	{desc="Down the callstack", noremap=true, silent=true}
)
map('n', '<leader>df', "<cmd>Telescope dap frames<CR>",
	{desc="Frames", noremap=true, silent=true}
)
map('n', '<leader>db', "<cmd>Telescope dap list_breakpoints<CR>",
	{desc="Breakpoints", noremap=true, silent=true}
)
map('n', '<F5>', "<cmd>lua require 'dap'.continue", {desc="Continue"})
map('n', '<F10>', "<cmd>lua require 'dap'.step_over", {desc="Step Over"})
map('n', '<F11>', "<cmd>lua require 'dap'.step_into", {desc="Step Into"})
map('n', '<F12>', "<cmd>lua require 'dap'.step_out", {desc="Step Out"})
map('n', '<leader>dt', "<cmd>lua require 'dap'.toggle_breakpoint", {desc="Toggle Breakpoint"})
