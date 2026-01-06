return {
  --  {
  --    "Joakker/lua-json5",
  --    build = "./install.sh",
  --    lazy = false,
  --    priority = 1000,
  --    enabled = not vim.g.vscode,
  --  },
  {
    "mfussenegger/nvim-dap",
    enabled = not vim.g.vscode,
    --config = function()
    --  require("dap.ext.vscode").json_decode = require("json5").parse
    -- end,
    keys = {
      { "<leader>dt", false },
      {
        "<leader>dx",
        function()
          require("dap").terminate()
        end,
        desc = "Terminate",
      },
    },
  },
}
