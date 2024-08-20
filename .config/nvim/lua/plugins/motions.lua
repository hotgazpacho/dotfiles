return {
  {
    "tris203/precognition.nvim",
    event = "VeryLazy",
    opts = function()
      return {
        startVisible = true,
        disabled_fts = {
          "dashboard",
        },
      }
    end,
    keys = {
      {
        "<leader>uP",
        function()
          if require("precognition").toggle() then
            LazyVim.info("precognition on")
          else
            LazyVim.info("precognition off")
          end
        end,
        desc = "Toggle precognition",
      },
      {
        "<leader>uk",
        function()
          require("precognition").peek()
        end,
        desc = "Show precognition until next motion",
      },
    },
  },
}
