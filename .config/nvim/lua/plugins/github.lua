return {
  {
    "pwntester/octo.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      {
        "folke/which-key.nvim",
        opts = {
          defaults = {
            ["<leader>gb"] = { name = "+github" },
            ["<leader>gp"] = { name = "+pullrequest" },
          },
        },
      },
    },
    config = function(_, opts)
      require("octo").setup(opts)
    end,
    cmd = "Octo",
    keys = {
      { "<leader>gbs", "<cmd>Octo search<cr>", desc = "Search" },
      { "<leader>gbb", "<cmd>Octo repo browser<cr>", desc = "open in Browser" },
      { "<leader>gpc", "<cmd>Octo pr checks<cr>", desc = "Checks status" },
      { "<leader>gps", "<cmd>Octo pr search<cr>", desc = "Search" },
      { "<leader>gpr", "<cmd>Octo pr ready<cr>", desc = "mark draft Ready" },
      { "<leader>gpb", "<cmd>Octo pr browser<cr>", desc = "view in Browser" },
      { "<leader>gpu", "<cmd>Octo pr url<cr>", desc = "copy URL" },
    },
  },
  {
    "ruifm/gitlinker.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = function()
      local opts = require("gitlinker.opts").get()
      local hosts = require("gitlinker.hosts")
      opts.callbacks = hosts.callbacks
      opts.mappings = nil
      return opts
    end,
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
