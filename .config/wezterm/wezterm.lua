local wezterm = require("wezterm")
local projects = require("projects")
local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- Leader
config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }

-- Keymap
local function move_pane(key, direction)
	return {
		key = key,
		mods = "LEADER",
		action = wezterm.action.ActivatePaneDirection(direction),
	}
end

local function resize_pane(key, direction)
	return {
		key = key,
		action = wezterm.action.AdjustPaneSize({ direction, 3 }),
	}
end

config.keys = {
	{
		key = "a",
		-- When we're in leader mode _and_ CTRL + A is pressed...
		mods = "LEADER|CTRL",
		-- Actually send CTRL + A key to the terminal
		action = wezterm.action.SendKey({ key = "a", mods = "CTRL" }),
	},
	{
		key = "|",
		mods = "LEADER|SHIFT",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "-",
		mods = "LEADER",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	move_pane("h", "Left"),
	move_pane("j", "Down"),
	move_pane("k", "Up"),
	move_pane("l", "Right"),
	{
		-- When we push LEADER + R...
		key = "r",
		mods = "LEADER",
		-- Activate the `resize_panes` keytable
		action = wezterm.action.ActivateKeyTable({
			name = "resize_panes",
			-- Ensures the keytable stays active after it handles its
			-- first keypress.
			one_shot = false,
			-- Deactivate the keytable after a timeout.
			timeout_milliseconds = 1000,
		}),
	},
	{
		key = "p",
		mods = "LEADER",
		-- Present in to our project picker
		action = projects.choose_project(),
	},
	{
		key = "f",
		mods = "LEADER",
		-- Present a list of existing workspaces
		action = wezterm.action.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" }),
	},
	{
		key = "w",
		mods = "LEADER",
		action = wezterm.action.ShowTabNavigator,
	},
	{
		key = "O",
		mods = "CTRL|SHIFT",
		action = wezterm.action.QuickSelectArgs({
			label = "open url",
			patterns = {
				"https?://\\S+",
			},
			action = wezterm.action_callback(function(window, pane)
				local url = window:get_selection_text_for_pane(pane)
				wezterm.log_info("opening: " .. url)
				wezterm.open_with(url)
			end),
		}),
	},
	{
		key = "J",
		mods = "CTRL|SHIFT",
		action = wezterm.action.QuickSelectArgs({
			label = "open jira",
			patterns = {
				"[A-Z][A-Z]+-\\d+",
			},
			action = wezterm.action_callback(function(window, pane)
				local jira = window:get_selection_text_for_pane(pane)
				local url = os.getenv("JIRA_URL") .. "/browse/" .. jira
				wezterm.log_info("opening: " .. url)
				wezterm.open_with(url)
			end),
		}),
	},
}

config.key_tables = {
	resize_panes = {
		resize_pane("j", "Down"),
		resize_pane("k", "Up"),
		resize_pane("h", "Left"),
		resize_pane("l", "Right"),
	},
}

-- Colorscheme
config.color_scheme = "Catppuccin Macchiato"
-- Font
config.font = wezterm.font_with_fallback({
	{ family = "Fira Code", weight = 450 },
	{ family = "Symbols Nerd Font Mono", scale = 0.9 },
})
config.font_size = 15.0
config.line_height = 1.0

-- Window
config.initial_rows = 60
config.initial_cols = 120
config.native_macos_fullscreen_mode = true

tabline.setup({
	options = {
		theme = "Catppuccin Macchiato",
		section_separators = {
			left = wezterm.nerdfonts.ple_right_half_circle_thick,
			right = wezterm.nerdfonts.ple_left_half_circle_thick,
		},
		component_separators = {
			left = wezterm.nerdfonts.ple_right_half_circle_thin,
			right = wezterm.nerdfonts.ple_left_half_circle_thin,
		},
		tab_separators = {
			left = wezterm.nerdfonts.ple_right_half_circle_thick,
			right = wezterm.nerdfonts.ple_left_half_circle_thick,
		},
	},
	sections = {
		tab_active = {
			{
				"process",
				process_to_icon = {
					["docker"] = wezterm.nerdfonts.linux_docker,
					["docker-compose"] = wezterm.nerdfonts.linux_docker,
					["k9s"] = wezterm.nerdfonts.md_kubernetes,
					["kubectl"] = wezterm.nerdfonts.md_kubernetes,
					["nvim"] = wezterm.nerdfonts.linux_neovim,
					["vim"] = wezterm.nerdfonts.dev_vim,
					["node"] = wezterm.nerdfonts.md_hexagon,
					["zsh"] = wezterm.nerdfonts.cod_terminal,
					["bash"] = wezterm.nerdfonts.cod_terminal_bash,
					["htop"] = wezterm.nerdfonts.md_chart_donut_variant,
					["cargo"] = wezterm.nerdfonts.dev_rust,
					["go"] = wezterm.nerdfonts.md_language_go,
					["lazydocker"] = wezterm.nerdfonts.linux_docker,
					["git"] = wezterm.nerdfonts.dev_git,
					["lazygit"] = wezterm.nerdfonts.dev_git,
					["eza"] = wezterm.nerdfonts.md_file_tree,
					["fzf"] = wezterm.nerdfonts.md_text_search_variant,
					["jless"] = wezterm.nerdfonts.md_application_braces_outline,
					["jq"] = wezterm.nerdfonts.md_code_json,
					["bat"] = wezterm.nerdfonts.md_bat,
					["cat"] = wezterm.nerdfonts.md_cat,
					["lua"] = wezterm.nerdfonts.seti_lua,
					["wget"] = wezterm.nerdfonts.md_arrow_down_box,
					["curl"] = wezterm.nerdfonts.md_flattr,
					["gh"] = wezterm.nerdfonts.cod_github,
					["python"] = wezterm.nerdfonts.dev_python,
					["python3"] = wezterm.nerdfonts.dev_python,
					["ruby"] = wezterm.nerdfonts.dev_ruby,
				},
				-- process_to_icon is a table that maps process to icons
			},
		},
		tab_inactive = {
			"index",
			{ "process", padding = { left = 0, right = 1 } },
			{ "cwd", padding = { left = 0, right = 1 } },
		},
		tabline_x = {}, -- disable default ram and cpu display
		tabline_z = {}, -- disable default hostname display
	},
})
tabline.apply_to_config(config)

return config
