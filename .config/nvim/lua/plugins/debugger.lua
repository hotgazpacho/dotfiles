return {
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
