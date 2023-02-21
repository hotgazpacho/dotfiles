return {
  -- https://github.com/maxmx03/solarized.nvim
  {
    "maxmx03/solarized.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      mode = "dark",
      theme = "neovim",
      transparent = false,
      highlights = function(colors, darken, lighten, blend)
        return {
          ["@constructor"] = { fg = colors.green },
          ["@property"] = { fg = colors.base0 },
          ["@tag"] = { fg = colors.yellow },
          ["@tag.delimiter"] = { fg = "#586e75" },
        }
      end,
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "solarized",
    },
  },
}
