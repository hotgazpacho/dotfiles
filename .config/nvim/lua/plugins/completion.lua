return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-emoji",
    },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local cmp = require("cmp")
      local types = require("cmp.types")

      -- Add emoji completion
      table.insert(opts.sources, { name = "emoji" })
    end,
  },
}
