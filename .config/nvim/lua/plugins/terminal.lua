return {
  {
    "willothy/flatten.nvim",
    enabled = not vim.g.vscode,
    config = true,
    lazy = false,
    priority = 1001,
    opts = {
      -- <String, Bool> dictionary of filetypes that should be blocking
      block_for = {
        gitcommit = true,
        gitrebase = true,
        markdown = true, -- gh pr create opens a markdown file to create the pr
      },
      window = {
        open = "alternate",
        diff = "tab_vsplit",
        focus = "first",
      },
    },
  },
}
