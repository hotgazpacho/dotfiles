local wezterm = require("wezterm")
local projects = require("projects")

local process_icons = {
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
}

local battery_icons = {
	[1.0] = wezterm.nerdfonts.md_battery,
	[0.9] = wezterm.nerdfonts.md_battery_90,
	[0.8] = wezterm.nerdfonts.md_battery_80,
	[0.7] = wezterm.nerdfonts.md_battery_70,
	[0.6] = wezterm.nerdfonts.md_battery_60,
	[0.5] = wezterm.nerdfonts.md_battery_50,
	[0.4] = wezterm.nerdfonts.md_battery_40,
	[0.3] = wezterm.nerdfonts.md_battery_30,
	[0.2] = wezterm.nerdfonts.md_battery_20,
	[0.1] = wezterm.nerdfonts.md_battery_10,
}

local battery_charging_icons = {
	[1.0] = wezterm.nerdfonts.md_battery_charging,
	[0.9] = wezterm.nerdfonts.md_battery_charging_90,
	[0.8] = wezterm.nerdfonts.md_battery_charging_80,
	[0.7] = wezterm.nerdfonts.md_battery_charging_70,
	[0.6] = wezterm.nerdfonts.md_battery_charging_60,
	[0.5] = wezterm.nerdfonts.md_battery_charging_50,
	[0.4] = wezterm.nerdfonts.md_battery_charging_40,
	[0.3] = wezterm.nerdfonts.md_battery_charging_30,
	[0.2] = wezterm.nerdfonts.md_battery_charging_20,
	[0.1] = wezterm.nerdfonts.md_battery_charging_10,
}

-- Equivalent to POSIX basename(3)
-- Given "/foo/bar" returns "bar"
-- Given "c:\\foo\\bar" returns "bar"
local function basename(s)
	return string.gsub(s, "(.*[/\\])(.*)", "%2")
end

local function get_process(tab)
	local process_name = basename(tab.active_pane.foreground_process_name)
	if string.find(process_name, "kubectl") then
		process_name = "kubectl"
	end

	--local icon = process_icons[process_name] or string.format("[%s]", process_name)
	local icon = process_icons[process_name] or wezterm.nerdfonts.cod_terminal

	return icon
end

-- wezterm.gui is not available to the mux server, so take care to
-- do something reasonable when this config is evaluated by the mux
local function get_appearance()
	if wezterm.gui then
		return wezterm.gui.get_appearance()
	end
	return "Dark"
end

local function scheme_for_appearance(appearance)
	if appearance:find("Dark") then
		return "Catppuccin Macchiato"
	else
		return "Catppuccin Latte"
	end
end

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
config.color_scheme = scheme_for_appearance(get_appearance())

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

-- Tab/Status bar
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = false
config.tab_max_width = 60
config.tab_bar_at_bottom = false
config.tab_bar_style = {
	new_tab = " " .. wezterm.nerdfonts.md_tab .. "  ",
	new_tab_hover = " " .. wezterm.nerdfonts.md_tab_plus .. "  ",
	window_close = " X ",
	window_close_hover = " X ",
	window_hide = " . ",
	window_hide_hover = " . ",
	window_maximize = " - ",
	window_maximize_hover = " - ",
}
wezterm.on("format-tab-title", function(tab, tabs, panes, cfg, hover, max_width)
	local title = string.format(
		"%d: %s %s",
		tab.tab_index + 1,
		get_process(tab),
		wezterm.truncate_left(tab.active_pane.title, max_width - 8)
	)
	local left_cap = wezterm.nerdfonts.ple_left_half_circle_thin
	local right_cap = wezterm.nerdfonts.ple_right_half_circle_thin
	local palette = cfg.resolved_palette
	local intensity = palette.tab_bar.inactive_tab.intensity
	local italic = palette.tab_bar.inactive_tab.italic
	local strikethrough = palette.tab_bar.inactive_tab.strikethrough
	local underline = palette.tab_bar.inactive_tab.underline
	local title_fg_color = palette.tab_bar.inactive_tab.fg_color
	local title_bg_color = palette.tab_bar.inactive_tab.bg_color
	local cap_fg_color = palette.tab_bar.inactive_tab.fg_color
	local cap_bg_color = palette.tab_bar.inactive_tab.bg_color

	if tab.is_active then
		intensity = palette.tab_bar.active_tab.intensity
		italic = palette.tab_bar.active_tab.italic
		strikethrough = palette.tab_bar.active_tab.strikethrough
		underline = palette.tab_bar.active_tab.underline
		title_fg_color = palette.tab_bar.active_tab.fg_color
		title_bg_color = palette.tab_bar.active_tab.bg_color
		cap_fg_color = palette.tab_bar.active_tab.bg_color
		cap_bg_color = palette.tab_bar.active_tab.fg_color
		left_cap = wezterm.nerdfonts.ple_left_half_circle_thick
		right_cap = wezterm.nerdfonts.ple_right_half_circle_thick
	elseif hover then
		intensity = palette.tab_bar.inactive_tab_hover.intensity
		italic = palette.tab_bar.inactive_tab_hover.italic
		strikethrough = palette.tab_bar.inactive_tab_hover.strikethrough
		underline = palette.tab_bar.inactive_tab_hover.underline
		title_fg_color = palette.tab_bar.inactive_tab_hover.fg_color
		title_bg_color = palette.tab_bar.inactive_tab_hover.bg_color
		cap_fg_color = palette.tab_bar.inactive_tab_hover.fg_color
		cap_bg_color = palette.tab_bar.inactive_tab_hover.bg_color
	end

	return {
		{ Attribute = { Intensity = intensity } },
		{ Attribute = { Italic = italic } },
		{ Attribute = { StrikeThrough = strikethrough } },
		{ Attribute = { Underline = underline } },
		{ Foreground = { Color = cap_fg_color } },
		{ Background = { Color = cap_bg_color } },
		{ Text = left_cap },
		{ Foreground = { Color = title_fg_color } },
		{ Background = { Color = title_bg_color } },
		{ Text = title },
		{ Foreground = { Color = cap_fg_color } },
		{ Background = { Color = cap_bg_color } },
		{ Text = right_cap },
		{ Foreground = { Color = palette.tab_bar.background } },
		{ Background = { Color = palette.tab_bar.background } },
		{ Text = " " },
	}
end)

wezterm.on("update-status", function(window, pane)
	local date = wezterm.strftime("%a %b %-d %-I:%M %p")
	local bat = ""
	local bat_color = "White"
	for _, b in ipairs(wezterm.battery_info()) do
		local state_rounded_down = math.floor(b.state_of_charge * 10) / 10
		if b.state == "Charging" then
			bat = battery_charging_icons[state_rounded_down] or wezterm.nerdfonts.md_battery_alert_variant_outline
		else
			bat = battery_icons[state_rounded_down] or wezterm.nerdfonts.md_battery_alert_variant_outline
		end
		bat = bat .. " " .. string.format("%.0f%%", b.state_of_charge * 100)

		if b.state_of_charge >= 0.8 then
			bat_color = "Lime"
		elseif b.state_of_charge >= 0.5 then
			bat_color = "White"
		elseif b.state_of_charge >= 0.2 then
			bat_color = "Yellow"
		else
			bat_color = "Red"
		end
	end

	window:set_right_status(wezterm.format({
		{ Attribute = { Italic = true } },
		{ Attribute = { Intensity = "Half" } },
		{ Foreground = { AnsiColor = "Silver" } },
		{ Text = " " .. wezterm.nerdfonts.md_calendar_clock_outline .. " " .. date },
		{ Foreground = { AnsiColor = bat_color } },
		{ Text = " " .. bat .. " " },
	}))
end)

return config
