local wezterm = require("wezterm")

local process_icons = {
	["docker"] = wezterm.nerdfonts.linux_docker,
	["docker-compose"] = wezterm.nerdfonts.linux_docker,
	["k9s"] = wezterm.nerdfonts.md_kubernetes,
	["kubectl"] = wezterm.nerdfonts.md_kubernetes,
	["nvim"] = wezterm.nerdfonts.linux_neovim,
	["vim"] = wezterm.nerdfonts.dev_vim,
	["node"] = wezterm.nerdfonts.md_hexagon,
	["zsh"] = wezterm.nerdfonts.dev_terminal,
	["bash"] = wezterm.nerdfonts.cod_terminal_bash,
	["htop"] = wezterm.nerdfonts.md_chart_donut_variant,
	["cargo"] = wezterm.nerdfonts.dev_rust,
	["go"] = wezterm.nerdfonts.md_language_go,
	["lazydocker"] = wezterm.nerdfonts.linux_docker,
	["git"] = wezterm.nerdfonts.dev_git,
	["lazygit"] = wezterm.nerdfonts.dev_git,
	["eza"] = wezterm.nerdfonts.md_file_tree,
	["fzf"] = wezterm.nerdfonts.md_text_search_variant,
	["lua"] = wezterm.nerdfonts.seti_lua,
	["wget"] = wezterm.nerdfonts.md_arrow_down_box,
	["curl"] = wezterm.nerdfonts.md_flattr,
	["gh"] = wezterm.nerdfonts.cod_github,
	["python"] = wezterm.nerdfonts.dev_python,
	["python3"] = wezterm.nerdfonts.dev_python,
	["ruby"] = wezterm.nerdfonts.dev_ruby,
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
	local icon = process_icons[process_name] or wezterm.nerdfonts.seti_checkbox_unchecked

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

-- Colorscheme
config.color_scheme = scheme_for_appearance(get_appearance())

-- Font
config.font = wezterm.font_with_fallback({
	"Fira Code",
	{ family = "Symbols Nerd Font Mono", scale = 1.0 },
})
config.font_size = 13.0

-- Window
config.initial_rows = 60
config.initial_cols = 120
config.native_macos_fullscreen_mode = true

-- Tab/Status bar
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = false
config.tab_max_width = 60
config.tab_bar_at_bottom = false
wezterm.on("format-tab-title", function(tab, tabs, panes, cfg, hover, max_width)
	local has_unseen_output = false
	if not tab.is_active then
		for _, pane in ipairs(tab.panes) do
			if pane.has_unseen_output then
				has_unseen_output = true
				break
			end
		end
	end

	local title = string.format(" %s %s  ⌘%d ", get_process(tab), tab.active_pane.title, tab.tab_index + 1)

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

wezterm.on("update-right-status", function(window, pane)
	local date = wezterm.strftime("%a %b %-d %-I:%M %p")

	-- Make it italic and underlined
	window:set_right_status(wezterm.format({
		{ Attribute = { Italic = true } },
		{ Text = " " .. wezterm.nerdfonts.md_calendar_clock_outline .. " " .. date .. " " },
	}))
end)

return config
