return {
  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function(_, opts)
      opts.fallback_severity = vim.diagnostic.severity.INFO
    end,
  },
}
