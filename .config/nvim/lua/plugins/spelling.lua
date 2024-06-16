local CSPELL_CONFIG_FILES = {
  "cspell.json",
  ".cspell.json",
  "cSpell.json",
  ".cspell.json",
  ".cspell.config.json",
}

---@param filename string
---@param cwd string
---@return string|nil
local function find_file(filename, cwd)
  ---@type string|nil
  local current_dir = cwd
  local root_dir = "/"

  repeat
    local file_path = current_dir .. "/" .. filename
    local stat = vim.loop.fs_stat(file_path)
    if stat and stat.type == "file" then
      return file_path
    end

    current_dir = vim.loop.fs_realpath(current_dir .. "/..")
  until current_dir == root_dir

  return nil
end

--- Find the first cspell.json file in the directory tree
---@param cwd string
---@return string|nil
local find_cspell_config_path = function(cwd)
  for _, file in ipairs(CSPELL_CONFIG_FILES) do
    local path = find_file(file, cwd or vim.loop.cwd())
    if path then
      return path
    end
  end
  return nil
end

--- Find the project .vscode directory, if any
---@param cwd string
---@return string|nil
local function find_vscode_config_dir(cwd)
  ---@type string|nil
  local current_dir = cwd
  local root_dir = "/"

  repeat
    local dir_path = current_dir .. "/.vscode"
    local stat = vim.loop.fs_stat(dir_path)
    if stat and stat.type == "directory" then
      return dir_path
    end

    current_dir = vim.loop.fs_realpath(current_dir .. "/..")
  until current_dir == root_dir

  return nil
end

return {
  {
    "davidmh/cspell.nvim",
    dependencies = { "Joakker/lua-json5" },
  },
  {
    "nvimtools/none-ls.nvim",
    opts = function(_, opts)
      local config = {
        find_json = function(cwd)
          local vscode_dir = find_vscode_config_dir(cwd)
          if vscode_dir ~= nil then
            return find_cspell_config_path(vscode_dir)
          end
          -- not in a project with vscode, so try to find the first cspell config in the tree
          return find_cspell_config_path(cwd)
        end,
        decode_json = require("json5").parse,
      }
      local cspell = require("cspell")
      table.insert(
        opts.sources,
        cspell.diagnostics.with({
          config = config,
          diagnostics_postprocess = function(diagnostic)
            diagnostic.severity = vim.diagnostic.severity["HINT"]
          end,
        })
      )
      table.insert(opts.sources, cspell.code_actions.with({ config = config }))
    end,
  },
}
