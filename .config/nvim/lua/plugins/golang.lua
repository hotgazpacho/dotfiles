return {
  {
    "ray-x/go.nvim",
    lazy = true,
    dependencies = { -- optional packages
      "mfussenegger/nvim-dap",
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      dap_debug = true,
      dap_debug_gui = true,
      dap_debug_keymap = true,
      dap_debug_vt = true,
      icons = { breakpoint = "🧘", currentpos = "🏃" },
      trouble = true,
      luasnip = true,
    },
    ft = { "go", "gomod", "gowork" },
    -- Use :GoInstallBinaries
    -- build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  },
}
