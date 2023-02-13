-- use vscode launch.json files, if present
require('dap.ext.vscode').load_launchjs(nil, {})

local dap, dapui =require("dap"),require("dapui")
dap.listeners.after.event_initialized["dapui_config"]=function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"]=function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"]=function()
  dapui.close()
end

require("nvim-dap-virtual-text").setup()

vim.fn.sign_define('DapBreakpoint',{ text ='🛑', texthl ='', linehl ='', numhl =''})
vim.fn.sign_define('DapBreakpointRejected',{ text='🚫', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapStopped',{ text ='▶️', texthl ='', linehl ='', numhl =''})
