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

-- process_to_icon is a table that maps process to icons
--[[ local scheme = tabline.config.scheme
local process_to_icon = {
	-- TODO: colors
	["eza"] = wezterm.nerdfonts.md_file_tree,
	["fzf"] = wezterm.nerdfonts.md_text_search_variant,
	["jless"] = wezterm.nerdfonts.md_application_braces_outline,
	["jq"] = wezterm.nerdfonts.md_code_json,
	["cat"] = wezterm.nerdfonts.md_cat,
	["python"] = wezterm.nerdfonts.dev_python,
	["python3"] = wezterm.nerdfonts.dev_python,

	["air"] = { wezterm.nerdfonts.md_language_go, color = { fg = scheme.brights[5] } },
	["apt"] = { wezterm.nerdfonts.dev_debian, color = { fg = scheme.ansi[2] } },
	["bacon"] = { wezterm.nerdfonts.dev_rust, color = { fg = scheme.ansi[2] } },
	["bash"] = { wezterm.nerdfonts.cod_terminal_bash, color = { fg = scheme.cursor_bg or nil } },
	["bat"] = { wezterm.nerdfonts.md_bat, color = { fg = scheme.ansi[5] } },
	["btm"] = { wezterm.nerdfonts.md_chart_donut_variant, color = { fg = scheme.ansi[2] } },
	["btop"] = { wezterm.nerdfonts.md_chart_areaspline, color = { fg = scheme.ansi[2] } },
	["btop4win++"] = { wezterm.nerdfonts.md_chart_areaspline, color = { fg = scheme.ansi[2] } },
	["bun"] = { wezterm.nerdfonts.md_hamburger, color = { fg = scheme.cursor_bg or nil } },
	["cargo"] = { wezterm.nerdfonts.dev_rust, color = { fg = scheme.ansi[2] } },
	["chezmoi"] = { wezterm.nerdfonts.md_home_plus_outline, color = { fg = scheme.brights[5] } },
	["cmd.exe"] = { wezterm.nerdfonts.md_console_line, color = { fg = scheme.cursor_bg or nil } },
	["curl"] = wezterm.nerdfonts.md_flattr,
	["debug"] = { wezterm.nerdfonts.cod_debug, color = { fg = scheme.ansi[5] } },
	["default"] = wezterm.nerdfonts.md_application,
	["docker"] = { wezterm.nerdfonts.linux_docker, color = { fg = scheme.ansi[5] } },
	["docker-compose"] = { wezterm.nerdfonts.linux_docker, color = { fg = scheme.ansi[5] } },
	["dpkg"] = { wezterm.nerdfonts.dev_debian, color = { fg = scheme.ansi[2] } },
	["fish"] = { wezterm.nerdfonts.md_fish, color = { fg = scheme.cursor_bg or nil } },
	["gh"] = { wezterm.nerdfonts.dev_github_badge, color = { fg = scheme.indexed[16] or nil } },
	["git"] = { wezterm.nerdfonts.dev_git, color = { fg = scheme.indexed[16] or nil } },
	["go"] = { wezterm.nerdfonts.md_language_go, color = { fg = scheme.brights[5] } },
	["htop"] = { wezterm.nerdfonts.md_chart_areaspline, color = { fg = scheme.ansi[2] } },
	["k9s"] = { wezterm.nerdfonts.md_kubernetes, color = { fg = scheme.ansi[5] } },
	["kubectl"] = { wezterm.nerdfonts.linux_docker, color = { fg = scheme.ansi[5] } },
	["kuberlr"] = { wezterm.nerdfonts.linux_docker, color = { fg = scheme.ansi[5] } },
	["lazydocker"] = { wezterm.nerdfonts.linux_docker, color = { fg = scheme.ansi[5] } },
	["lazygit"] = { wezterm.nerdfonts.cod_github, color = { fg = scheme.indexed[16] or nil } },
	["lua"] = { wezterm.nerdfonts.seti_lua, color = { fg = scheme.ansi[5] } },
	["make"] = wezterm.nerdfonts.seti_makefile,
	["nix"] = { wezterm.nerdfonts.linux_nixos, color = { fg = scheme.ansi[5] } },
	["node"] = { wezterm.nerdfonts.md_nodejs, color = { fg = scheme.brights[2] } },
	["npm"] = { wezterm.nerdfonts.md_npm, color = { fg = scheme.brights[2] } },
	["nvim"] = { wezterm.nerdfonts.custom_neovim, color = { fg = scheme.ansi[4] } },
	["pacman"] = { wezterm.nerdfonts.md_pac_man, color = { fg = scheme.ansi[4] } },
	["paru"] = { wezterm.nerdfonts.md_pac_man, color = { fg = scheme.ansi[4] } },
	["pnpm"] = { wezterm.nerdfonts.md_npm, color = { fg = scheme.brights[4] } },
	["postgresql"] = { wezterm.nerdfonts.dev_postgresql, color = { fg = scheme.ansi[5] } },
	["powershell.exe"] = { wezterm.nerdfonts.md_console, color = { fg = scheme.cursor_bg or nil } },
	["psql"] = { wezterm.nerdfonts.dev_postgresql, color = { fg = scheme.ansi[5] } },
	["pwsh.exe"] = { wezterm.nerdfonts.md_console, color = { fg = scheme.cursor_bg or nil } },
	["rpm"] = { wezterm.nerdfonts.dev_redhat, color = { fg = scheme.ansi[2] } },
	["redis"] = { wezterm.nerdfonts.dev_redis, color = { fg = scheme.ansi[5] } },
	["ruby"] = { wezterm.nerdfonts.cod_ruby, color = { fg = scheme.brights[2] } },
	["rust"] = { wezterm.nerdfonts.dev_rust, color = { fg = scheme.ansi[2] } },
	["serial"] = wezterm.nerdfonts.md_serial_port,
	["ssh"] = wezterm.nerdfonts.md_pipe,
	["sudo"] = wezterm.nerdfonts.fa_hashtag,
	["tls"] = wezterm.nerdfonts.md_power_socket,
	["topgrade"] = { wezterm.nerdfonts.md_rocket_launch, color = { fg = scheme.ansi[5] } },
	["unix"] = wezterm.nerdfonts.md_bash,
	["valkey"] = { wezterm.nerdfonts.dev_redis, color = { fg = scheme.brights[5] } },
	["vim"] = { wezterm.nerdfonts.dev_vim, color = { fg = scheme.ansi[3] } },
	["wget"] = wezterm.nerdfonts.md_arrow_down_box,
	["yarn"] = { wezterm.nerdfonts.seti_yarn, color = { fg = scheme.ansi[5] } },
	["yay"] = { wezterm.nerdfonts.md_pac_man, color = { fg = scheme.ansi[4] } },
	["yazi"] = { wezterm.nerdfonts.md_duck, color = { fg = scheme.indexed[16] or nil } },
	["yum"] = { wezterm.nerdfonts.dev_redhat, color = { fg = scheme.ansi[2] } },
	["zsh"] = { wezterm.nerdfonts.dev_terminal, color = { fg = scheme.cursor_bg or nil } },
} ]]

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
			"index",
			{
				"process",
				padding = { left = 0, right = 1 },
				-- process_to_icon = process_to_icon,
			},
			{ "parent", padding = 0 },
			"/",
			{ "cwd", padding = { left = 0, right = 1 } },
		},
		tab_inactive = {
			"index",
			{
				"process",
				padding = { left = 0, right = 1 },
				-- process_to_icon = process_to_icon,
			},
			{ "parent", padding = 0 },
			"/",
			{ "cwd", padding = { left = 0, right = 1 } },
		},
		tabline_x = {}, -- disable default ram and cpu display
		tabline_z = {}, -- disable default hostname display
	},
})
tabline.apply_to_config(config)

return config
