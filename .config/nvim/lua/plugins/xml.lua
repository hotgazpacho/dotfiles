return {
  -- setup lspconfig
  {
    "neovim/nvim-lspconfig",
    opts = {
      -- make sure mason installs the server
      servers = {
        lemminx = {},
      },
    },
  },
}
