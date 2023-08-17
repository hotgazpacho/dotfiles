return {
  {
    "vim-test/vim-test",
    enabled = not vim.g.vscode,
    dependencies = {
      {
        "folke/which-key.nvim",
        opts = {
          defaults = {
            ["<leader>t"] = { name = "+test" },
          },
        },
      },
    },
    config = true,
    init = function()
      vim.g["test#strategy"] = "neovim"
    end,
    keys = {
      { "<leader>tt", "<cmd>TestNearest<cr>", desc = "Test nearest" },
      { "<leader>tf", "<cmd>TestFile<cr>", desc = "Test File" },
      { "<leader>ts", "<cmd>TestSuite<cr>", desc = "Test Suite" },
      { "<leader>tl", "<cmd>TestLast<cr>", desc = "Test Last" },
      { "<leader>tv", "<cmd>TestVisit", desc = "Visit test file" },
    },
  },
}
