return {
  {
    "AckslD/nvim-neoclip.lua",
    lazy = false,
    config = function(_, opts)
      require("neoclip").setup(opts)
      require("telescope").load_extension("neoclip")
    end,
  },
}
