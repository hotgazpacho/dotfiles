return {
  {
    "AckslD/nvim-neoclip.lua",
    event = { "TextYankPost" },
    opts = {},
    keys = {
      { "<leader>sy", "<cmd>Telescope neoclip unnamed<cr>", desc = "Clipboard (default register)" },
      { '<leader>s"', "<cmd>Telescope neoclip unnamed<cr>", desc = 'Clipboard (" register)' },
      { "<leader>s*", "<cmd>Telescope neoclip star<cr>", desc = "Clipboard (* register)" },
      { "<leader>s+", "<cmd>Telescope neoclip plus<cr>", desc = "Clipboard (+ register)" },
    },
  },
}
