return {
  {
    "Joakker/lua-json5",
    build = "./install.sh && mv lua/json5.dylib lua/json5.so",
    lazy = false,
    priority = 1000,
  },
  {
    "mfussenegger/nvim-dap",
    enabled = not vim.g.vscode,
    config = function()
      require("dap.ext.vscode").json_decode = require("json5").parse
      require("dap.ext.vscode").load_launchjs(nil, {})
      -- Note: copied from https://github.com/LazyVim/LazyVim/blob/81ab5bed7a81c3005f862d6508dacc26c4ed553a/lua/lazyvim/plugins/extras/dap/core.lua#L92-L101
      -- Any time LzyVim is updated, need to verify this.
      local Config = require("lazyvim.config")
      vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

      for name, sign in pairs(Config.icons.dap) do
        sign = type(sign) == "table" and sign or { sign }
        vim.fn.sign_define(
          "Dap" .. name,
          { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
        )
      end
    end,
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
