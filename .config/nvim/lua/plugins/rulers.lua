return {
  "m4xshen/smartcolumn.nvim",
  enabled = false, -- not vim.g.vscode,
  opts = {
    colorcolumn = {
      "100",
    },
    custom_colorcolumn = {
      proto = "80",
      gitcommit = "80",
    },
    disabled_filetypes = {
      "NeoTree",
      "help",
      "text",
      "lazy",
      "mason",
      "dashboard",
      "alpha_dashboard",
      "snacks_dashboard",
      "lspinfo",
      "Trouble",
      "zsh",
    },
  },
}
