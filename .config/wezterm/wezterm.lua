local wezterm = require("wezterm")

return {
	font = wezterm.font("FiraCode Nerd Font Mono", { weight = "Regular" }),
	font_size = 13.0,
	color_scheme = "tokyonight-storm",
	front_end = "WebGpu",
	hide_tab_bar_if_only_one_tab = true,
	initial_rows = 60,
	initial_cols = 120,
}
