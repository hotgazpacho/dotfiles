return {
  {
    "willothy/flatten.nvim",
    -- Ensure that it runs first to minimize delay when opening file from terminal
    lazy = false,
    priority = 1001,
    opts = {
      callbacks = {
        pre_open = function()
          require("toggleterm").toggle()
        end,
        post_open = function(_, winnr)
          local term = require("toggleterm.terminal").get_last_focused() -- <--- Here
          if not term or not term:is_float() then
            term:toggle()
          end
          api.nvim_set_current_win(winnr)
        end,
        block_end = function()
          require("toggleterm").toggle()
        end,
      },
      -- <String, Bool> dictionary of filetypes that should be blocking
      block_for = {
        gitcommit = true,
      },
      -- Window options
      window = {
        -- Options:
        -- current        -> open in current window (default)
        -- alternate      -> open in alternate window (recommended)
        -- tab            -> open in new tab
        -- split          -> open in split
        -- vsplit         -> open in vsplit
        -- current        -> open in current window
        -- func(new_bufs) -> only open the files, allowing you to handle window opening yourself.
        -- Argument is an array of buffer numbers representing the newly opened files.
        open = "alternate",
        -- Affects which file gets focused when opening multiple at once
        -- Options:
        -- "first"        -> open first file of new files (default)
        -- "last"         -> open last file of new files
        focus = "first",
      },
    },
  },
  {
    "akinsho/toggleterm.nvim",
    cmd = { "ToggleTerm", "TermExec" },
    keys = {
      { [[C-\]], "<cmd>ToggleTerm<cr>", desc = "Toggle Terminal" },
    },
    opts = {
      -- size can be a number or function which is passed the current terminal
      size = function(term)
        if term.direction == "horizontal" then
          return 15
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.3
        end
      end,
      shade_terminals = false,
      open_mapping = [[<C-\>]],
      shading_factor = 2,
      direction = "vertical",
      float_opts = {
        border = "curved",
        highlights = { border = "Normal", background = "Normal" },
      },
      winbar = {
        enabled = true,
        name_formatter = function(term)
          return string.format("%d:%s", term.id, term:_display_name())
        end,
      },
    },
  },
}
