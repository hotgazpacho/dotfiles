return {
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      {
        "folke/which-key.nvim",
        opts = {
          defaults = {
            ["<leader>r"] = { name = "+refactor" },
            ["<leader>rp"] = { name = "+print debug" },
          },
        },
      },
    },
    opts = {
      -- prompt for return type
      prompt_func_return_type = {
        go = true,
        cpp = true,
        c = true,
        java = true,
      },
      -- prompt for function parameters
      prompt_func_param_type = {
        go = true,
        cpp = true,
        c = true,
        java = true,
      },
    },
    config = function(_, opts)
      require("refactoring").setup(opts)
      require("telescope").load_extension("refactoring")
    end,
    keys = {
      -- These refactorings require a visual mode selection.
      {
        "<leader>rr",
        "<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>",
        "v",
        desc = "Select Refactoring",
        noremap = true,
        silent = true,
        expr = false,
      },
      {
        "<leader>re",
        [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>]],
        "v",
        desc = "Extract Function",
        noremap = true,
        silent = true,
        expr = false,
      },
      {
        "<leader>rf",
        [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function To File')<CR>]],
        "v",
        desc = "Extract Function to File",
        noremap = true,
        silent = true,
        expr = false,
      },
      {
        "<leader>rv",
        [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Variable')<CR>]],
        "v",
        desc = "Extract Variable",
        noremap = true,
        silent = true,
        expr = false,
      },
      {
        "<leader>ri",
        [[ <Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]],
        "v",
        desc = "Inline Variable",
        noremap = true,
        silent = true,
        expr = false,
      },
      -- These refactorings don't require visual mode.
      {
        "<leader>rb",
        [[ <Cmd>lua require('refactoring').refactor('Extract Block')<CR>]],
        desc = "Extract Block",
        noremap = true,
        silent = true,
        expr = false,
      },
      {
        "<leader>rbf",
        [[ <Cmd>lua require('refactoring').refactor('Extract Block To File')<CR>]],
        desc = "Extract Block to File",
        noremap = true,
        silent = true,
        expr = false,
      },
      -- Inline variable can also pick up the identifier currently under the cursor without visual mode.
      {
        "<leader>ri",
        [[ <Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]],
        desc = "Inline Variable",
        noremap = true,
        silent = true,
        expr = false,
      },
      -- debug
      {
        "<leader>rpa",
        "<Cmd>lua require('refactoring').debug.printf({below = false})<CR>",
        desc = "Debug Print Above",
        noremap = true,
      },
      {
        "<leader>rpb",
        "<Cmd>lua require('refactoring').debug.printf({below = true})<CR>",
        desc = "Debug Print Below",
        noremap = true,
      },
      -- Remap in normal mode and passing { normal = true } will automatically find the variable under the cursor and print it
      {
        "<leader>rv",
        "<Cmd>lua require('refactoring').debug.print_var({ normal = true })<CR>",
        desc = "Debug Print Variable",
        noremap = true,
      },
      -- Remap in visual mode will print whatever is in the visual selection
      {
        "<leader>rv",
        "<Cmd>lua require('refactoring').debug.print_var({})<CR>",
        desc = "Debug Print Selection",
        noremap = true,
      },
      {
        "<leader>rc",
        "<Cmd>lua require('refactoring').debug.cleanup({})<CR>",
        desc = "Debug Print Cleanup",
        noremap = true,
      },
    },
  },
}
