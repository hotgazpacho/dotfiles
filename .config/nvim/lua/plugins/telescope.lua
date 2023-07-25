return {
  -- add telescope-fzf-native
  {
    "telescope.nvim",
    dependencies = {
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        config = function()
          require("telescope").load_extension("fzf")
        end,
      },
      {
        "nvim-telescope/telescope-dap.nvim",
        config = function()
          require("telescope").load_extension("dap")
        end,
        keys = {
          {
            "<leader>df",
            function()
              require("telescope").extensions.dap.configurations({})
            end,
            desc = "Con(f)igurations",
          },
          {
            "<leader>dv",
            function()
              require("telescope").extensions.dap.variables({})
            end,
            desc = "Variables",
          },
        },
      },
      {
        "rcarriga/nvim-notify",
        config = function(_, opts)
          require("notify").setup(opts)
          require("telescope").load_extension("notify")
        end,
        keys = {
          {
            "<leader>fN",
            "<cmd>Telescope notify<cr>",
            desc = "Notifications",
          },
        },
      },
      {
        "sudormrfbin/cheatsheet.nvim",
        config = true,
        keys = {
          {
            "<leader>?",
            "<cmd>Cheatsheet<cr>",
            desc = "Cheatsheet",
          },
        },
      },
    },
  },
}
