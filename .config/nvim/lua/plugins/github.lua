return {
  {
    "nvimtools/none-ls.nvim",
    opts = function(_, opts)
      --      table.insert(opts.sources, require("null-ls.builtins.diagnostics.commitlint"))
      table.insert(opts.sources, require("null-ls.builtins.code_actions.gitrebase"))
      table.insert(opts.sources, require("null-ls.builtins.code_actions.gitsigns"))
    end,
    enabled = not vim.g.vscode,
  },
  {
    "ruifm/gitlinker.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    enabled = not vim.g.vscode,
    opts = {
      mappings = nil,
    },
    keys = {
      {
        "<leader>gy",
        function()
          require("gitlinker").get_buf_range_url("n")
        end,
        desc = "Copy git link",
        mode = { "n" },
      },
      {
        "<leader>gy",
        function()
          require("gitlinker").get_buf_range_url("v")
        end,
        desc = "Copy git link",
        mode = { "v" },
      },
      {
        "<leader>gY",
        function()
          require("gitlinker").get_repo_url()
        end,
        desc = "Copy repo url",
        mode = { "n" },
      },
      {
        "<leader>gb",
        function()
          require("gitlinker").get_buf_range_url(
            "n",
            { action_callback = require("gitlinker.actions").open_in_browser, print_url = false }
          )
        end,
        desc = "Open git link in browser",
        mode = { "n" },
      },
      {
        "<leader>gb",
        function()
          require("gitlinker").get_buf_range_url(
            "v",
            { action_callback = require("gitlinker.actions").open_in_browser, print_url = false }
          )
        end,
        desc = "Open git link in browser",
        mode = { "v" },
      },
      {
        "<leader>gB",
        function()
          require("gitlinker").get_repo_url({
            action_callback = require("gitlinker.actions").open_in_browser,
            print_url = false,
          })
        end,
        desc = "Open repo in browser",
        mode = { "n" },
      },
    },
  },
}
