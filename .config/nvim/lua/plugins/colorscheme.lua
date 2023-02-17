return {
  -- https://github.com/maxmx03/solarized.nvim
  {
    "maxmx03/solarized.nvim",
    config = function()
      local success, solarized = pcall(require, "solarized")

      if not success then
        return
      end

      solarized.setup({
        mode = "dark",
        theme = "vim",
        transparnet = true,
      })
    end,
  },
  -- Configure LazyVim to load solarized
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "solarized",
    },
  },
}
