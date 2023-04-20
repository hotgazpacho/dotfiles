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
      dap_debug_keymap = false,
      trouble = true,
      luasnip = true,
    },
    config = function(_, opts)
      require("go").setup(opts)
    end,
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    -- Use :GoInstallBinaries
    -- build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  },
}
