return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      {
        "jay-babu/mason-nvim-dap.nvim",
        dependencies = { "nvim-dap" },
        cmd = { "DapInstall", "DapUninstall" },
        opts = { automatic_setup = true },
        config = function()
          local mason_nvim_dap = require("mason-nvim-dap")
          mason_nvim_dap.setup()
          mason_nvim_dap.setup_handlers({})
        end,
      },
      {
        "rcarriga/nvim-dap-ui",
        opts = { floating = { border = "rounded" } },
        config = function()
          local dap, dapui = require("dap"), require("dapui")
          dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open()
          end
          dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close()
          end
          dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close()
          end
          dapui.setup()
        end,
      },
      {
        "folke/neodev.nvim",
        opts = {
          library = {
            plugins = { "nvim-dap-ui" },
            types = true,
          },
        },
      },
      {
        "theHamsta/nvim-dap-virtual-text",
        config = function()
          require("nvim-dap-virtual-text").setup()
        end,
      },
    },
  },
}
