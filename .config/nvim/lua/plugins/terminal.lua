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
      },
      callbacks = {
        should_block = function(argv)
          -- Note that argv contains all the parts of the CLI command, including
          -- Neovim's path, commands, options and files.
          -- See: :help v:argv

          -- In this case, we would block if we find the `-b` flag
          -- This allows you to use `nvim -b file1` instead of `nvim --cmd 'let g:flatten_wait=1' file1`
          return vim.tbl_contains(argv, "-b")

          -- Alternatively, we can block if we find the diff-mode option
          -- return vim.tbl_contains(argv, "-d")
        end,
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
    },
  },
  {
    "akinsho/toggleterm.nvim",
    dependencies = {
      {
        "folke/which-key.nvim",
        opts = {
          defaults = {
            ["<leader>/"] = { name = "+terminal" },
          },
        },
      },
    },
    cmd = { "ToggleTerm", "TermExec" },
    keys = {
      { [[<C-/>]], "<cmd>ToggleTerm<cr>", desc = "Toggle Terminal" },
      { [[<leader>/f]], "<cmd>ToggleTerm direction=float<cr>", desc = "ToggleTerm float" },
      { [[<leader>/h]], "<cmd>ToggleTerm direction=horizontal<cr>", desc = "ToggleTerm horizontal split" },
      { [[<leader>/v]], "<cmd>ToggleTerm direction=vertical<cr>", desc = "ToggleTerm vertical split" },
      { [[<leader>/<tab>]], "<cmd>ToggleTerm direction=tab<cr>", desc = "ToggleTerm tab" },
      { [[<leader>/a]], "<cmd>ToggleTermToggleAll<cr>", desc = "ToggleTerm all at once" },
      { [[<leader>/n]], "<cmd>ToggleTermSetName<cr>", desc = "Set Terminal Name" },
    },
    opts = {
      -- size can be a number or function which is passed the current terminal
      size = function(term)
        if term.direction == "horizontal" then
          return 15
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.4
        end
      end,
      shade_terminals = false,
      open_mapping = [[<C-/>]],
      shading_factor = 2,
      direction = "vertical",
      float_opts = {
        border = "curved",
        highlights = { border = "Normal", background = "Normal" },
      },
      winbar = {
        enabled = false,
        name_formatter = function(term)
          return string.format("%d:%s", term.id, term:_display_name())
        end,
      },
    },
  },
}
