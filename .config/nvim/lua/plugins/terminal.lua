return {
  {
    "willothy/flatten.nvim",
    config = true,
    lazy = false,
    priority = 1001,
    opts = {
      -- <String, Bool> dictionary of filetypes that should be blocking
      block_for = {
        gitcommit = true,
        markdown = true, -- gh pr create opens a markdown file to create the pr
      },
      window = {
        open = "alternate",
        focus = "first",
      },
    },
  },
}
