return {
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
}
