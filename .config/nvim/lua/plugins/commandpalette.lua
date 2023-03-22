return {
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    config = function()
      require("dressing").setup({
        select = {
          get_config = function(opts)
            opts = opts or {}
            local cfg = {
              telescope = {
                layout_config = {
                  width = 120,
                  height = 25,
                },
              },
            }
            if opts.kind == "legendary.nvim" then
              cfg.telescope.sorter = require("telescope.sorters").fuzzy_with_index_bias({})
            end
            return cfg
          end,
        },
      })
    end,
  },
  {
    "mrjones2014/legendary.nvim",
    lazy = false,
    config = function()
      require("legendary").setup({
        which_key = { auto_register = true },
      })
    end,
  },
  {
    "folke/which-key.nvim",
    dependencies = {
      "mrjones2014/legendary.nvim",
    },
  },
}
