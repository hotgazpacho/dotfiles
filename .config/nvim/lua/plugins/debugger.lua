return {
  {
    "Joakker/lua-json5",
    build = "./install.sh && mv lua/json5.dylib lua/json5.so",
    lazy = false,
    priority = 1000,
  },
  {
    "mfussenegger/nvim-dap",
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
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    version = "2.0.1",
    opts = {
      automatic_setup = true,
      ensure_installed = {
        "js-debug-adapter",
        "delve",
      },
    },
  },
  {
    "mxsdev/nvim-dap-vscode-js",
    dependencies = { "nvim-dap" },
    opts = {
      debugger_path = vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter",
      debugger_cmd = { "js-debug-adapter" },
      adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" }, -- which adapters to register in nvim-dap
    },
    config = function(_, opts)
      require("dap-vscode-js").setup(opts)

      for _, language in ipairs({ "typescript", "javascript" }) do
        require("dap").configurations[language] = {
          {
            {
              type = "pwa-node",
              request = "launch",
              name = "Launch file",
              program = "${file}",
              cwd = "${workspaceFolder}",
            },
            {
              type = "pwa-node",
              request = "attach",
              name = "Attach",
              processId = require("dap.utils").pick_process,
              cwd = "${workspaceFolder}",
            },
          },
          {
            type = "pwa-node",
            request = "launch",
            name = "Debug Jest Tests",
            -- trace = true, -- include debugger info
            runtimeExecutable = "node",
            runtimeArgs = {
              "./node_modules/jest/bin/jest.js",
              "--runInBand",
            },
            rootPath = "${workspaceFolder}",
            cwd = "${workspaceFolder}",
            console = "integratedTerminal",
            internalConsoleOptions = "neverOpen",
          },
        }
      end
    end,
  },
}
