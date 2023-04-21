return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/neotest-go",
      "nvim-neotest/neotest-jest",
      {
        "folke/which-key.nvim",
        opts = {
          defaults = {
            ["<leader>t"] = { name = "+test" },
          },
        },
      },
    },
    opts = function()
      return {
        adapters = {
          require("neotest-go"),
          require("neotest-jest"),
        },
      }
    end,
    config = function(_, opts)
      -- get neotest namespace (api call creates or returns namespace)
      local neotest_ns = vim.api.nvim_create_namespace("neotest")
      vim.diagnostic.config({
        virtual_text = {
          format = function(diagnostic)
            local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
            return message
          end,
        },
      }, neotest_ns)
      require("neotest").setup(opts)
    end,
    keys = {
      {
        "<leader>tS",
        function()
          require("neotest").run.run(vim.fn.getcwd())
        end,
        desc = "run suite",
      },
      {
        "<leader>tt",
        function()
          require("neotest").run.run()
        end,
        desc = "run nearest",
      },
      {
        "<leader>tl",
        function()
          require("neotest").run.run_last()
        end,
        desc = "run last",
      },
      {
        "<leader>tf",
        function()
          require("neotest").run.run(vim.fn.expand("%"))
        end,
        desc = "run current file",
      },
      {
        "<leader>td",
        function()
          require("neotest").run.run({ strategy = "dap" })
        end,
        desc = "debug nearest",
      },
      {
        "<leader>tD",
        function()
          require("neotest").run.run_last({ strategy = "dap" })
        end,
        desc = "debug last",
      },
      {
        "<leader>tx",
        function()
          require("neotest").run.stop()
        end,
        desc = "stop test run",
      },
      {
        "<leader>to",
        function()
          require("neotest").output.open({ enter = true })
        end,
        desc = "show output",
      },
      {
        "<leader>tp",
        function()
          require("neotest").output_panel.toggle()
        end,
        desc = "output panel",
      },
      {
        "<leader>ts",
        function()
          require("neotest").summary.toggle()
        end,
        desc = "summary",
      },
    },
  },
}
