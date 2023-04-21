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
        config = function()
          require("telescope").load_extension("notify")
        end,
      },
      {
        "sudormrfbin/cheatsheet.nvim",
        config = true,
        keys = {
          {
            "<leader>C",
            "<cmd>Cheatsheet<cr>",
            desc = "Cheatsheet",
          },
        },
      },
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- add a keymap to browse plugin files
      -- stylua: ignore
      {
        "<leader>fp",
        function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end,
        desc = "Find Plugin File",
      },
    },
  },
}
