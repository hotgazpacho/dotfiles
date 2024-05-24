local wezterm = require("wezterm")

local process_icons = {
	["docker"] = {
		{ Text = wezterm.nerdfonts.linux_docker },
	},
	["docker-compose"] = {
		{ Text = wezterm.nerdfonts.linux_docker },
	},
	["kuberlr"] = {
		{ Text = wezterm.nerdfonts.linux_docker },
	},
	["kubectl"] = {
		{ Text = wezterm.nerdfonts.linux_docker },
	},
	["nvim"] = {
		{ Text = wezterm.nerdfonts.custom_vim },
	},
	["vim"] = {
		{ Text = wezterm.nerdfonts.dev_vim },
	},
	["node"] = {
		{ Text = wezterm.nerdfonts.mdi_hexagon },
	},
	["zsh"] = {
		{ Text = wezterm.nerdfonts.dev_terminal },
	},
	["bash"] = {
		{ Text = wezterm.nerdfonts.cod_terminal_bash },
	},
	["htop"] = {
		{ Text = wezterm.nerdfonts.mdi_chart_donut_variant },
	},
	["cargo"] = {
		{ Text = wezterm.nerdfonts.dev_rust },
	},
	["go"] = {
		{ Text = wezterm.nerdfonts.mdi_language_go },
	},
	["lazydocker"] = {
		{ Text = wezterm.nerdfonts.linux_docker },
	},
	["git"] = {
		{ Text = wezterm.nerdfonts.dev_git },
	},
	["lazygit"] = {
		{ Text = wezterm.nerdfonts.dev_git },
	},
	["lua"] = {
		{ Text = wezterm.nerdfonts.seti_lua },
	},
	["wget"] = {
		{ Text = wezterm.nerdfonts.mdi_arrow_down_box },
	},
	["curl"] = {
		{ Text = wezterm.nerdfonts.mdi_flattr },
	},
	["gh"] = {
		{ Text = wezterm.nerdfonts.dev_github_badge },
	},
	["python"] = {
		{ Text = wezterm.nerdfonts.dev_python },
	},
	["python3"] = {
		{ Text = wezterm.nerdfonts.dev_python },
	},
	["ruby"] = {
		{ Text = wezterm.nerdfonts.dev_ruby },
	},
}

local function get_current_working_dir(tab)
	local current_dir = tab.active_pane.current_working_dir
	local HOME_DIR = string.format("file://%s", os.getenv("HOME"))

	return current_dir == HOME_DIR and "." or string.gsub(current_dir.string, "(.*[/\\])(.*)", "%2")
end

local function get_process(tab)
	local process_name = string.gsub(tab.active_pane.foreground_process_name, "(.*[/\\])(.*)", "%2")
	if string.find(process_name, "kubectl") then
		process_name = "kubectl"
	end

	return wezterm.format(process_icons[process_name] or { { Text = string.format("[%s]", process_name) } })
end

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local has_unseen_output = false
	if not tab.is_active then
		for _, pane in ipairs(tab.panes) do
			if pane.has_unseen_output then
				has_unseen_output = true
				break
			end
		end
	end

	local title = string.format(
		" %s  %s ~ %s  ⌘%d ",
		wezterm.nerdfonts.fa_chevron_right,
		get_process(tab),
		get_current_working_dir(tab),
		tab.tab_index + 1
	)

	if has_unseen_output then
		return {
			{ Foreground = { Color = "Orange" } },
			{ Text = title },
		}
	end

	return {
		{ Text = title },
	}
end)

-- wezterm.gui is not available to the mux server, so take care to
-- do something reasonable when this config is evaluated by the mux
function get_appearance()
	if wezterm.gui then
		return wezterm.gui.get_appearance()
	end
	return "Dark"
end

function scheme_for_appearance(appearance)
	if appearance:find("Dark") then
		return "Catppuccin Macchiato"
	else
		return "Catppuccin Latte"
	end
end

return {
	font = wezterm.font_with_fallback({
		"Fira Code",
		{ family = "Symbols Nerd Font Mono", scale = 1.0 },
	}),
	font_size = 13.0,
	use_cap_height_to_scale_fallback_fonts = true,
	window_frame = {
		font = wezterm.font_with_fallback({
			"Fira Code",
			{ family = "Symbols Nerd Font Mono", scale = 1.0 },
		}),
	},
	color_scheme = scheme_for_appearance(get_appearance()),
	hide_tab_bar_if_only_one_tab = true,
	initial_rows = 60,
	initial_cols = 120,
	native_macos_fullscreen_mode = true,
}
