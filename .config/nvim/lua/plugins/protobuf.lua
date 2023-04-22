return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "buf", "buf-language-server" })
    end,
  },
  -- add proto to treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "proto" })
      end
    end,
  },
  -- setup lspconfig
  {
    "neovim/nvim-lspconfig",
    opts = {
      -- make sure mason installs the server
      servers = {
        bufls = {},
      },
    },
  },
  -- add buf diagnostics
  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function(_, opts)
      table.insert(opts.sources, require("null-ls.builtins.diagnostics.buf"))
    end,
  },
}
