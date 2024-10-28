local wezterm = require("wezterm")
local M = {}

local function h(path)
	if not path then
		return wezterm.home_dir
	end
	return wezterm.home_dir .. "/" .. path
end

local function project_dirs()
	local dirs = { h("Development/*"), h("Projects/*") }
	local projects = { h(), h(".config") }
	for _, dir in ipairs(dirs) do
		for _, p in ipairs(wezterm.glob(dir)) do
			table.insert(projects, p)
		end
	end
	return projects
end

function M.choose_project()
	local choices = {}
	for _, value in ipairs(project_dirs()) do
		table.insert(choices, { label = value })
	end

	return wezterm.action.InputSelector({
		title = "Workspaces",
		choices = choices,
		fuzzy = true,
		action = wezterm.action_callback(function(child_window, child_pane, id, label)
			if label then
				child_window:perform_action(
					wezterm.action.SwitchToWorkspace({
						name = label:match("([^/]+)$"),
						spawn = {
							cwd = label,
						},
					}),
					child_pane
				)
			end
		end),
	})
end
return M
