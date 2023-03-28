local wezterm = require("wezterm")

return {
	font = wezterm.font_with_fallback({
		"Fira Code",
		{ family = "Symbols Nerd Font Mono", scale = 1.0 },
	}),
	font_size = 13.0,
	use_cap_height_to_scale_fallback_fonts = true,
	color_scheme = "tokyonight-storm",
	hide_tab_bar_if_only_one_tab = true,
	initial_rows = 60,
	initial_cols = 120,
}
