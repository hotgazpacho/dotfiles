return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "clang-format", "prettierd" })
    end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function(_, opts)
      table.insert(opts.sources, require("null-ls.builtins.formatting.clang_format"))
      table.insert(opts.sources, require("null-ls.builtins.formatting.prettierd"))
    end,
  },
}
