return {
  {
    "pwntester/octo.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
    cmd = "Octo",
    config = true,
  },
  {
    "ruifm/gitlinker.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = true,
    opts = function()
      local opts = require("gitlinker.opts").get()
      local hosts = require("gitlinker.hosts")
      opts.callbacks = hosts.callbacks
      opts.mappings = nil
      return opts
    end,
    keys = { "<leader>g" },
  },
}
