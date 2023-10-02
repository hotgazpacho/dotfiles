return {
  {
    "nvimtools/none-ls.nvim",
    opts = function(_, opts)
      opts.fallback_severity = vim.diagnostic.severity.INFO
    end,
  },
}
