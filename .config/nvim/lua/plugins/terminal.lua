return {
  {
    "willothy/flatten.nvim",
    -- Ensure that it runs first to minimize delay when opening file from terminal
    lazy = false,
    priority = 1001,
    opts = {
      callbacks = {
        post_open = function(bufnr, winnr, ft, is_blocking)
          if is_blocking then
            -- Hide the terminal while it's blocking
            require("toggleterm").toggle(0)
          else
            -- If it's a normal file, just switch to its window
            vim.api.nvim_set_current_win(winnr)
          end

          -- If the file is a git commit, create one-shot autocmd to delete its buffer on write
          -- If you just want the toggleable terminal integration, ignore this bit
          if ft == "gitcommit" then
            vim.api.nvim_create_autocmd("BufWritePost", {
              buffer = bufnr,
              once = true,
              callback = function()
                -- This is a bit of a hack, but if you run bufdelete immediately
                -- the shell can occasionally freeze
                vim.defer_fn(function()
                  vim.api.nvim_buf_delete(bufnr, {})
                end, 50)
              end,
            })
          end
        end,
        block_end = function()
          -- After blocking ends (for a git commit, etc), reopen the terminal
          require("toggleterm").toggle(0)
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
