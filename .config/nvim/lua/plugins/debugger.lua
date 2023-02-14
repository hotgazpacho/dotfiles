return {
  { "mfussenegger/nvim-dap" },
  {
    "theHamsta/nvim-dap-virtual-text",
    config = function()
      require("nvim-dap-virtual-text").setup()
    end,
  },
  { "rcarriga/nvim-dap-ui" },
  { "folke/neodev.nvim", opts = { library = { plugins = { "nvim-dap-ui" }, types = true } } },
}
